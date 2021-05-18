function [] = dibujarGrafico(graph, moves)
%Visualizar el gráfico y sus nodos y aristas.
hold on

%Dibujar una línea entre cada nodo
for i = 1:graph.n-1
    for j = i+1:graph.n
        %dibujar solo si existe conexión
        if moves(i,j) == 1
            %Punto del primer nodo
            x1 = graph.node(i).x;
            x2 = graph.node(j).x;
            %Punto del segundo nodo
            y1 = graph.node(i).y;
            y2 = graph.node(j).y;
            %Vectores
            X = [x1, x2];
            Y = [y1, y2];
        
            plot(X,Y,'-k', 'Marker', '^');
        end
    end
end

%Dibujar circulos en los nodos
X = [graph.node(:).x];
Y = [graph.node(:).y];
for i = 1:graph.n
    if graph.node(i).tipo == 0
        plot(X(i),Y(i),'-s','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','k');
    elseif graph.node(i).tipo == 1
        plot(X(i),Y(i),'-s','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','r');
    elseif graph.node(i).tipo == 2
        plot(X(i),Y(i),'-p','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','b');
    elseif graph.node(i).tipo == 3
        plot(X(i),Y(i),'-v','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','r');
    end
end
    title('Nodos y aristas');
    box('on');



end
