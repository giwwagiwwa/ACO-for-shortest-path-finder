function [] = dibujarBestTour( colonia, graph )

queenPath = colonia.queen.path;
hold on;
for i=1:length(queenPath)-1
    
    currentNode = queenPath(i);
    nextNode = queenPath(i+1);
    
    x1 = graph.node(currentNode).x;
    y1 = graph.node(currentNode).y;
    
    x2 = graph.node(nextNode).x;
    y2 = graph.node(nextNode).y;
    
    X = [x1,x2];
    Y = [y1,y2];
    
    plot(X,Y,'-r');

end

    X = [graph.node(queenPath).x];
    Y = [graph.node(queenPath).y];
for i=1:length(queenPath)
   if graph.node(queenPath(i)).tipo == 0
        plot(X(i),Y(i),'-s','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','k');
    elseif graph.node(queenPath(i)).tipo == 1
        plot(X(i),Y(i),'-s','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','r');
    elseif graph.node(queenPath(i)).tipo == 2
        plot(X(i),Y(i),'-p','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','b');
    elseif graph.node(queenPath(i)).tipo == 3
        plot(X(i),Y(i),'-v','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','r');
    end
end

title('Best path (the queen)');
box('on');
end