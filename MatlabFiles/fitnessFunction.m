function [fitness] = fitnessFunction (tour, graph)
%parametros = ruta (tour), coste del desplazamiento

fitness = 0;
%sumamos todas las distancias entre nodos de la ruta de la hormiga.
for i=1:length(tour)-1
    currentNode = tour(i);
    nextNode = tour(i+1);
    
    fitness = fitness + graph.edges(currentNode,nextNode);
    
end