function [graph] = crearGraficoCiudades(puntos,moves)
%Función que genera el entorno del problema al workspace de Matlab. Obtiene
%una estructura que contiene toda la información de cada nodo (coordenadas
%X, Y, tipo de nodo, nombre de la ciudad y movimientos disponibles). 
%También calcula las distancias en km entre ciudades a partir de la latitud
% y la longitud.

%Tamaño del gráfico = total nodos.
graph.n = length(puntos);

%Añadimos las coordenadas de cada punto al grafico.
for i=1:graph.n
    graph.node(i).x = puntos(i).x; %Añadir coord x al nodo i
    graph.node(i).y = puntos(i).y; %Añadir coord y al nodo i
    graph.node(i).tipo = puntos(i).tipo;
    %Añadimos los 1s a los movimientos posibles.
    graph.node(i).move = find(moves(i,:));
    %Nombre de las ciudades
    graph.node(i).ciu = puntos(i).ciu;
end
%Flag que indica a la hora de mostrar los resultados que existen nombres
graph.ciu = 'si';

%Parametro matriz que contiene las distancias entre nodos.
graph.edges = zeros(graph.n, graph.n);

%Distancias
for i=1:graph.n
    for j=1:graph.n
        %Calculo de la distancia euclidiana entre cada punto
        lon1 = (graph.node(i).x)*pi/180; %convertidos a radianes
        lon2 = (graph.node(j).x)*pi/180;
        
        lat1 = (graph.node(i).y)*pi/180;
        lat2 = (graph.node(j).y)*pi/180;
        
        %Fórmula a partir de un radio de 6371km para calcular distancias en
        %km para dos puntos con sus latitudes y longitudes.
        graph.edges(i,j) = 6371 * acos(sin(lat1)*sin(lat2)+cos(lat1)*cos(lat2)*cos(lon2-lon1));
    end
end

end
