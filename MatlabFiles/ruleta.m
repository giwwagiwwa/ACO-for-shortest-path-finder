function [nextNode] = ruleta(P)
%Elige un nodo basandose en la probabilidad.

%Calculo de la suma acumulada de P
cumsumP = cumsum(P);
%Numero aleatorio
r = rand();
%Buscamos el nodo que cumple:
nextNode = find( r <= cumsumP);
%Nos quedamos con el primero
nextNode = nextNode(1);
end