function [graph] = crearGrafico(puntos,moves)
%Calcular la distancia entre cada nodo
%Tamaño del gráfico = total de variables en X.
graph.n = length(puntos);

%Añadimos las coordenadas de cada punto al grafico.
for i=1:graph.n
    graph.node(i).x = puntos(i).x; %Añadir coord x al nodo i
    graph.node(i).y = puntos(i).y; %Añadir coord y al nodo i
    graph.node(i).tipo = puntos(i).tipo;
    %Añadimos los 1 a los movimientos posibles.
    graph.node(i).move = find(moves(i,:));
end

%Parametro matriz que contiene las distancias entre nodos.
graph.edges = zeros(graph.n, graph.n);

%Distancias
for i=1:graph.n
    for j=1:graph.n
        %Calculo de la distancia euclidiana entre cada punto
        x1 = graph.node(i).x;
        x2 = graph.node(j).x;
        
        y1 = graph.node(i).y;
        y2 = graph.node(j).y;
        
        graph.edges(i,j) = sqrt( (x1-x2)^2 + (y1-y2)^2 );
    end
end

end