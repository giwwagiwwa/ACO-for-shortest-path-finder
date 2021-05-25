function [] = dibujarGrafico(graph, moves)
%Visualizar el gráfico, sus nodos y aristas con los nodos disponibles,
%indicado por la matriz moves

hold on

%Dibujar una línea entre cada nodo
for i = 1:graph.n-1
    for j = i+1:graph.n
        %anular moves diagonal
        moves(i,i) = 0;
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
    for j = 1:i-1
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
        plot(X(i),Y(i),'-s','MarkerSize',15,'MarkerEdgeColor','k','MarkerFaceColor','k');
        if graph.n < 300
            text(X(i),Y(i),num2str(i),'Color','w','Fontsize',10,'VerticalAlignment','middle','HorizontalAlignment','center');
        end
    elseif graph.node(i).tipo == 1
        plot(X(i),Y(i),'-s','MarkerSize',15,'MarkerEdgeColor','k','MarkerFaceColor','g');
        if graph.n < 300
            text(X(i),Y(i),num2str(i),'Fontsize',10,'VerticalAlignment','middle','HorizontalAlignment','center');
        end
    elseif graph.node(i).tipo == 2
        plot(X(i),Y(i),'-p','MarkerSize',15,'MarkerEdgeColor','k','MarkerFaceColor','b');
        if graph.n < 300
            text(X(i),Y(i),num2str(i),'Fontsize',10,'VerticalAlignment','cap','HorizontalAlignment','center');
        end
    elseif graph.node(i).tipo == 3
        plot(X(i),Y(i),'-v','MarkerSize',15,'MarkerEdgeColor','k','MarkerFaceColor','r');
        if graph.n < 300
            text(X(i),Y(i),num2str(i),'Fontsize',10,'VerticalAlignment','cap','HorizontalAlignment','center');
        end
    end
    if isequal(graph.ciu,'si')
        text(X(i),Y(i),graph.node(i).ciu,'Fontsize',9,'VerticalAlignment','cap','HorizontalAlignment','center');
    end
end
    title('Mapa de nodos y movimientos');
    box('on');



end
