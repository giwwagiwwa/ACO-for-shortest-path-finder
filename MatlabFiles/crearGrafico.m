function [graph] = crearGrafico(puntos,moves)
%Funci�n que genera el entorno del problema al workspace de Matlab. Obtiene
%una estructura que contiene toda la informaci�n de cada nodo (coordenadas
%X, Y, tipo de nodo y movimientos disponibles). Tambi�n calcula las
%distancias euclidianas entre nodos.

%Tama�o del gr�fico = total nodos.
graph.n = length(puntos);

%A�adimos las coordenadas de cada punto al grafico.
for i=1:graph.n
    graph.node(i).x = puntos(i).x; %A�adir coord x al nodo i
    graph.node(i).y = puntos(i).y; %A�adir coord y al nodo i
    graph.node(i).tipo = puntos(i).tipo; %A�adir tipo de nodo
    %A�adimos los 1s a los movimientos posibles.
    graph.node(i).move = find(moves(i,:));
end
%Flag que indica a la hora de mostrar los resultados que no existen nombres
graph.ciu = 'no';

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
        
        %distancia entre i(1) y j(2) = raiz((ix-jx)^2 + (iy-jy)^2)
        graph.edges(i,j) = sqrt( (x1-x2)^2 + (y1-y2)^2 );
    end
end

end