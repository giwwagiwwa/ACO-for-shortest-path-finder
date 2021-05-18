function [tau] = actualizarFerom(tau,colonia)

%Calculamos el numero de nodos del path de cada hormiga.
antNo = length(colonia.ant(:));
for i=1:antNo
    nodeNo = length(colonia.ant(i).path);
    for j=1:nodeNo-1
        currentNode = colonia.ant(i).path(j);
        nextNode = colonia.ant(i).path(j+1);
        
        %Actualizar tau:
        %Sumar a la tau anterior (todavia sin evaporar) la inversa de la
        %longitud del camino = fitness.
        tau(currentNode,nextNode) = tau(currentNode,nextNode)+1./colonia.ant(i).fitness;
        tau(nextNode,currentNode) = tau(nextNode,currentNode)+1./colonia.ant(i).fitness;
        %La matriz Tau tiene que ser simetrica (mismo nivel de feromina de
        %3 a 4 que de 4 a 3).
    end
end

end