function [fitness] = fitnessFunction (path, graph)
%Calcula el coste del desplazamiento entre inicio y final.

fitness = 0;
% sumamos todas las distancias entre nodos de la ruta de la hormiga.
for i=1:length(path)-1
    currentNode = path(i);
    nextNode = path(i+1);
    
    fitness = fitness + graph.edges(currentNode,nextNode);
    
end