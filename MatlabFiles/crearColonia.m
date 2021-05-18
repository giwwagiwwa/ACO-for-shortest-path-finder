function [colonia] = crearColonia(graph, colonia, antNo, tau, eta, alpha, beta)
destinationNode = graph.n;
%Ejecutar el bucle para todas las hormigas. En el bucle while se traza una
%ruta completa de inicio al final. Nodo final = último nodo
for i=1:antNo
   %variable por si hay que retroceder
   retroceder = 0;
   colonia.ant(i).path(1) = 1;
   %Propiedad .path de la ant i que incluye los nodos visitados en la ruta
   %A partir del primero, los siguientes se escogerán por probabilidad
   %Recorremos el resto de nodos
   while 1
       %Seleccionamos el nodo último del .tour de la hormiga
       currentNode = colonia.ant(i).path(end);
       %MODIFICAR
       %Calcular las probabilidades de los nodos para desplazarse con
       %la formula del algoritmo permitidos en move
       P_allNodes = zeros(1,graph.n);
       for j = 1:length(graph.node(currentNode).move)
        P_allNodes(graph.node(currentNode).move(j)) = tau( currentNode, graph.node(currentNode).move(j) ).^alpha .* eta( currentNode, graph.node(currentNode).move(j) ).^beta;
       end
       %Anular las probabilidades calculadas para los nodos donde no se
       %puede mover la hormiga.
%        anularP = zeros(1,graph.n+1);
%        for j = 1:length(graph.node(currentNode).move)
%            anularP(graph.node(currentNode).move(j)) = anularP(graph.node(currentNode).move(j))+1;
%        end
%        %Anular las prob
%        for k=1:length(P_allNodes)
%            if anularP(k) == 0
%                P_allNodes(k) = 0;
%            end
%        end

       %Para evitar desplazarse hacia atras en la ruta, la probabilidad de
       %los nodos del tour es 0:
       P_allNodes(colonia.ant(i).path) = 0;
       
       %Ajustamos probabilide
       P = P_allNodes ./sum(P_allNodes);
       %Ruleta para seleccionar el movimiento.
       %Check de que almenos 1 nodo tiene P diferente de NaN
       if isnan(P)
           %if there isn't any available node, the ant goes back until
           %there is another available node to travel.
           nextNode = colonia.ant(i).path(end-(2*retroceder+1));
           retroceder = retroceder +1;
       else
           %if there is at least 1 node available, we call the ruleta
           %function to chose it based on the probability calculated
           nextNode = ruleta(P);
           %reset the move back counter
           retroceder = 0;
       end
       %Si no hay ningun nodo disponible, se vuelve al anterior
       %Añadimos el nodo al path
       colonia.ant(i).path = [colonia.ant(i).path, nextNode];
       if nextNode == destinationNode
           break %when we find the final node, the path is completed next ant starts its path
       end
   end
end

end