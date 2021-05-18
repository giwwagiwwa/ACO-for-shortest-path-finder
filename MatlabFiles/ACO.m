clear
close all
%% Preparación del problema
%Colores inicio final
color_inici = [230,0,0]; %rgb of initial dot colour (red)
color_final = [0,0,230]; %rgb of final dot colour (blue)
%Nombre del mapa a cargar:
mapa = ''; %map image name with extension
ruta = ''; %path to the folder of maps images
%Obtenemos los puntos a partir del mapa de imagen y la matriz moves
[ptot,moves] = img2xy(color_inici,color_final,ruta,mapa);
%Restriction:
    %Start node lower left box (first point)
    %End node upper right box (last point)
%% Generación del gráfico:
%Vector X,Y de coordenadas de los nodos
[graph] = crearGrafico(ptot,moves);
    %.n = Numero de nodos
    %.node(i).x = Coordenada X del nodo i
    %.node(i).y = Coordenada Y del nodo i
    %.node(i).move = Nodos a los cuales se puede desplazar
    %.edges(i,j) = Distancia euclidiana entre el nodo i y el j

%CHECK GRAPH
for i=1:graph.n
    if isempty(graph.node(i).move) & graph.node(i).tipo > 0
        disp(i);
    end
end
    
%Dibujar el grafico
figure
subplot(1,3,1);
dibujarGrafico(graph, moves);

%% ACO algorithm ------------------------------------------------

%% Initial parameters of ACO
%Maximas iteraciones del algoritmo
    maxiter = 100;
%Numero de ants
    antNo = 5;
%Nivel de feromona inicial
%Se puede empezar des de 0 también (Comienzo 100% aleatorio). El valor de 10 puede variar
    tau0 = 1*1/( graph.n * mean( graph.edges(:) ));
%De este modo se distribuye el nivel de feromona razonablemente.
%Matriz de feromonas de las aristas a partir del inicial
    tau = tau0 * ones(graph.n, graph.n);
%Calcular eta (atractivo de cada camino) = la inversa de la longitud = más
%corto mejor
    eta = 1./graph.edges;
%Factor de evaporación:
    rho = 0.35; % '%' que se evapora cada iteración
%Alfa y Beta
    alpha = 1;
    beta = 1;
    
%% Main loop ACO
%el mejor coste inicial (maximo), buscamos el mínimo coste.
bestTour = [];
bestFitness = inf;

for t=1:maxiter
   %Create Ants
   colonia = [];
   colonia = crearColonia( graph, colonia, antNo, tau, eta, alpha, beta );
   
   %Calculate the fitness values of all ants (how good an ant is)
   %fitness value = evaluar la solución 
   for i=1:antNo
      colonia.ant(i).fitness = fitnessFunction( colonia.ant(i).path,graph ); 
   end
   
   %Find the best ant (queen)
   %movemos todos los costes calculados a una nueva variable.
   allAntsFitness = [ colonia.ant(:).fitness ];
   %Buscamos el menor coste (valor y indice del array).
   [minVal, minIndex] = min( allAntsFitness );
   %Actualizamos el mejor coste y tour si es el caso.
   if minVal < bestFitness
       bestFitness = minVal;
       bestTour = colonia.ant( minIndex ).path;
   end
   
   %Actualizamos la hormiga reina
   colonia.queen.path = bestTour;
   colonia.queen.fitness = bestFitness;
   
   %Update pheromone matrix (by how good is every path)
   tau = actualizarFerom( tau , colonia );
   
   %Evaporation
   %Ratio de feromonas que se evaporan en cada iteración
   tau = ( 1 - rho ) .* tau;
   
   %Display results
   outmsg = ['Iteración #',num2str(t),' Camino más corto = ',num2str(colonia.queen.fitness)];
   disp(outmsg);
   
   %Visualizar el mejor tour y la concentración de feromonas.
   subplot(1,3,2);
   %Limpiar la figura sin cerrarla (cla)
   cla
   dibujarBestTour( colonia, graph );

    %Dibujar los niveles de feromona consume muchos recursos del pc
    subplot(1,3,3);
    cla
    dibujarFerom( tau, graph );
   
   drawnow
end