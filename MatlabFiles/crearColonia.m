function [colonia] = crearColonia(graph, colonia, antNo, tau, eta, alpha, beta, startnode, endnode)
%Genera caminos para todas las hormigas de la colonia definidos en antNo.
%Cada desplazamiento calcula la probabilidad (si hay algun nodo
%disponible), sino vuelve atrás hasta que haya uno disponible. Cuando el
%siguiente nodo es el destino, pasa a la siguiente hormiga hasta que se ha
%realizado esta operación en todas.

destinationNode = endnode;
%Ejecutar el bucle para todas las hormigas. En el bucle while se traza una
%ruta completa de inicio al final.
for i=1:antNo
   %variable por si hay que retroceder
   retroceder = 0;
   colonia.ant(i).path(1) = startnode;
   %Propiedad .path de la ant i, incluye los nodos visitados en la ruta
   %A partir del primero, los siguientes se escogerán por probabilidad
   %Recorremos el resto de nodos hasta el break (destination)
   while 1
       %Seleccionamos el nodo último del .tour de la hormiga
       currentNode = colonia.ant(i).path(end);

       %Calcular las probabilidades de los nodos disponibles para desplazarse con
       %la formula del algoritmo
       %Inicialización de la matriz de probabilidades según el número de
       %nodos
       P_allNodes = zeros(1,graph.n); 
       %Recorre el vector moves disponible para el currentNode y solamente
       %calcula la probabilidad de desplazarse a los nodos que aparecen.
       for j = 1:length(graph.node(currentNode).move)
        P_allNodes(graph.node(currentNode).move(j)) = tau( currentNode, graph.node(currentNode).move(j) ).^alpha .* eta( currentNode, graph.node(currentNode).move(j) ).^beta;
       end

       %Para evitar desplazarse hacia atras en la ruta, la probabilidad de
       %los nodos del tour es 0:
       P_allNodes(colonia.ant(i).path) = 0;
       
       %Ajustamos probabilides mediante la suma cumulativa.
       P = P_allNodes ./sum(P_allNodes);
       %Ruleta para seleccionar el movimiento.
       %Check de que almenos 1 nodo tiene P diferente de NaN
       if isnan(P)
           %si no hay un nodo disponible para viajar (NaN) vuelve atrás en
           %el path hasta que haya uno disponible
           nextNode = colonia.ant(i).path(end-(2*retroceder+1));
           retroceder = retroceder +1;
       else
           %si hay almenos 1 nodo con P diferente de NaN usamos la función
           %ruleta para seleccionar el siguiente nodo
           nextNode = ruleta(P);
           %reset el contador de retroceso
           retroceder = 0;
       end
       %Si no hay ningun nodo disponible, se vuelve al anterior
       %Añadimos el nodo al path
       colonia.ant(i).path = [colonia.ant(i).path, nextNode];
       %Si hemos llegado al siguiente se termina el bucle de la hormiga i,
       %y se pasa a la siguiente
       if nextNode == destinationNode
           break
       end
   end
end

end