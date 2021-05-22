clear
close all

%% Definici�n de entorno usado
%Si se usan mapas laberinto de bitmaps:
    %Imagen del mapa de la carpeta mapas
    mapa = ''; %deixar en blanc si no s'utilitzen laberints
    %Colores inicio final
    col_start = [230,0,0]; %rgb of initial dot colour (red)
    col_end = [0,0,230]; %rgb of final dot colour (blue)

    %Restricci�n para el uso de mapas de bits:
        %Nodo inicial px inferior izquierdo (primer punto)
        %Nodo final px superior derecho (�ltimo punto)
%--------------------------------------------------------------------------
%Si se usan mapas hechos de generaMapaNodes.m o de ciudades
    mapselect = 4; 
    %(1 - Mapa peque�o,2 - Mapa mediano ,3 - Mapa real de hormigas,
    % 4 - Simulaci�n por entorno de ciudades espa�olas)
%--------------------------------------------------------------------------
%% Generaci�n de puntos X, Y, moves
if isempty(mapa)
%Manual X,Y, moves declaration:
    if mapselect < 4 
        %si se usan mapas diferentes del 4 se utiliza la funci�n
        %generaMapaNodes --> puntos y moves ya definidos
        [X,Y,moves] = generaMapaNodes(mapselect);
        initial_node = 1;
        destination_node = length(X);
    else
        %Si se utiliza el mapa 4 de las ciudades, se carga des de la hoja
        %de excel principales_ciudades.xls
        [~,~,raw] = xlsread('./mapas/principales_ciudades.xls',1,'A2:F47');
        %figure
        for c = 1:length(raw)
            ciudades(c).pro = string(raw(c,1));
            ciudades(c).ciu = string(raw(c,2));
            ciudades(c).lat = cell2mat(raw(c,3));
            ciudades(c).lon = cell2mat(raw(c,4));
            ciudades(c).id  = cell2mat(raw(c,6));
            text = split(string(raw(c,5)),";");
            ciudades(c).moves = str2double(text(:));
            
            %plot(ciudades(c).lon,ciudades(c).lat,'o');
            %hold on;
        end
        %Introducci�n de ciudad inicio y fin por el usuario
        disp("Introduce los nombres de las ciudades del excel con comillas (p.ej 'Barcelona')");
        ciu_ini = input('Ciudad inicio: ');
        ciu_fin = input('Ciudad final: ');
        %close
        [X,Y,moves,initial_node,destination_node] = generaMapaCiutats(ciudades,ciu_ini,ciu_fin);
        clearvars col_end col_start raw
    end
    
    %Para los casos de mapa de nodos utilizamos una variable auxiliar que
    %continene la informaci�n del mapa antes de generar el grafico
    for i=1:length(X)
        ptot(i).x = X(i);
        ptot(i).y = Y(i);
        ptot(i).tipo = 1;
        if mapselect > 3
            ptot(i).ciu = ciudades(i).ciu;
        end
    end
    %Definici�n de nodos inicio/fin
    ptot(initial_node).tipo = 3;
    ptot(destination_node).tipo = 2;
else
    %En caso de usar mapas laberintos se utiliza la funci�n img2xy
    %Obtenemos los puntos a partir del mapa de imagen y la matriz moves
    [ptot,moves] = img2xy(col_start,col_end,mapa);
    %por defecto el punto 1 es el inicio y el final el �ltimo
    initial_node = 1;
    destination_node = length(ptot);
end

%% Generaci�n de gr�fico
if mapselect < 4 || ~isempty(mapa)
    %Vector X,Y de coordenadas de los nodos
    [graph] = crearGrafico(ptot,moves);
else %Ejemplo ciudades con c�lculo de distancias a partir de latitud y lon
    [graph] = crearGraficoCiudades(ptot,moves);
end
    %.n = Numero de nodos
    %.ciu = nombre ciudad (solo para el caso de ciudades)
    %.node(i).x = X coord of node i
    %.node(i).y = Y coord of node i
    %.node(i).move = Nodes to which ants can move from node i
    %.node(i).tipo = Node type (0-wall,1-point,2-finish,3-start)    
    %.edges(i,j) = Distancia euclidiana entre el nodo i y el j
                  %Distancia en km entre nodos i y j para caso de ciudades
    
%Dibujar el grafico
figure
subplot(1,3,1);
dibujarGrafico(graph, moves);

%% Parametros iniciales del ACO (tunning)
%Maximas iteraciones del algoritmo
    maxIter = 30;
%Numero de hormigas
    antNo = 10;
%Nivel de feromona inicial
%Se puede empezar des de ~0 tambi�n (Comienzo 100% aleatorio).
    tau0 = 10*1/( graph.n * mean( graph.edges(:) )); %Comienzo normalizado para las longitudes del gr�fico
    %De este modo se distribuye el nivel de feromona razonablemente.
    %tau0 = 0.01; %Comienzo con constante
%Matriz de feromonas de las aristas a partir del inicial
    tau = tau0 * ones(graph.n, graph.n);
%Calcular eta (atractivo de cada camino) = la inversa de la longitud = m�s
%corto mejor
    eta = 1./graph.edges;
%Factor de evaporaci�n:
    rho = 0.75; % '%' que se evapora cada iteraci�n --> 1 - rho = feromonas que se mantienen.
%Alfa y Beta
    alpha = 0.5; %Control de la influencia de tau (niveles de feromona) al calcular las probabilidades
    beta = 1;%Control de la influencia de eta (atractivo del camino) al calcular las probabilidades
    
%% Bucle del ACO
bestPath = []; %Variable que almacena los nodos del mejor trayecto
bestFitness = zeros(maxIter,1); %Mejor coste del trayecto
iterFoundAbs = 0;%Indica la iteraci�n absoluta en la que se ha encontrado el mejor camino
iterFoundRel = 0;%Indica la iteraci�n relativa al �ltimo mejor trayecto en la que se ha encontrado el nuevo mejor camino
bestFitness(1) = Inf; %Inicializaci�n del menor coste como Infinito.
iterAntsFitness = zeros(maxIter,antNo); %Variable que contiene todos los costes de las hormigas

pause

for t=1:maxIter
    %Craci�n de la colonia y ejecuci�n de la funci�n crearColonia:
    %Cada hormiga de la colonia realiza su trayecto del initial_node al
    %destination_node
    colonia = [];
    colonia = crearColonia( graph, colonia, antNo, tau, eta, alpha, beta, initial_node,destination_node);

    %Calcular los valores de aptitud de todos los caminos de las hormigas (lo bueno que es una hormiga) 
    for i=1:antNo
      colonia.ant(i).fitness = fitnessFunction( colonia.ant(i).path,graph ); 
    end

    %Encuentra la mejor hormiga (reina)
    %Movemos todos los costes calculados a una nueva variable.
    allAntsFitness = [ colonia.ant(:).fitness ];
    %Buscamos el menor coste (valor y indice del array).
    [minVal, minIndex] = min( allAntsFitness );
    iterAntsFitness(t,:) = allAntsFitness;
    %Actualizamos el mejor coste y tour si es el caso.
    if t == 1
       bestFitness(t) = minVal;
       bestPath = colonia.ant( minIndex ).path;
    elseif minVal < bestFitness(t-1)
       bestFitness(t) = minVal;
       bestPath = colonia.ant( minIndex ).path;
       iterFoundAbs = t;
       iterFoundRel = t - iterFoundRel;
    else
        bestFitness(t) = bestFitness(t-1);
    end
    %Actualizamos la hormiga reina
    colonia.queen.path = bestPath;
    colonia.queen.fitness = bestFitness(t);

    %Actualizamos la matriz de feromonas
    tau = actualizarFerom( tau , colonia );

    %Evaporaci�n
    %Ratio de feromonas que se evaporan en cada iteraci�n = rho, se
    %mantienen 1 - rho
    tau = ( 1 - rho ) .* tau;

    %Mostrar resultados de los caminos de la iteraci�n t
    outmsg = ['Iteraci�n #',num2str(t),' Camino m�s corto = ',num2str(colonia.queen.fitness)];
    disp(outmsg);

    %Visualizar el mejor tour y la concentraci�n de feromonas.
    subplot(1,3,2);
    %Limpiar la figura sin cerrarla (cla)
    cla
    dibujarBestTour( colonia, graph );

    %Dibujar los niveles de feromona (consume muchos recursos del pc para
    %gr�ficos con m�s de ~80 puntos).
    subplot(1,3,3);
    cla
    dibujarFerom( tau, graph );

    drawnow
end
%Mostramos los resultados en n�meros de nodo si no se usa el ejemplo de las
%ciudades
if mapselect < 4 || ~isempty(mapa)
    outmsg = ['Camino m�s corto = ',num2str(colonia.queen.fitness),'. Encontrado a la iter n� ',num2str(iterFoundAbs),'. Best path:'];
    disp(outmsg);
    disp(bestPath);
else
    outmsg = ['Ruta m�s corta: ',num2str(colonia.queen.fitness),' km. Encontrado a la iter n� ',num2str(iterFoundAbs),'. Best path:'];
    disp(outmsg);
    disp('Ruta de ciudades: ');
    outmsg = [ciudades(bestPath).ciu];
    disp(outmsg);
end

%Resumen de los caminos escogidos y la distancia, etc..
% figure
% plot(iterAntsFitness,'o');
% hold on;
% plot(bestFitness,'-r');