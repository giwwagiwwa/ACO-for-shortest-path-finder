function [] = dibujarBestTour( colonia, graph )
%Función que genera una representación gráfica del mejor recorrido 
%(menor distancia).

%variable local del mejor recorrido
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
    
    %dibujamos las líneas que unen los puntos del mejor recorrido
    plot(X,Y,'--or');
end
%Dibujar nombres de los nodos
    X = [graph.node(queenPath).x];
    Y = [graph.node(queenPath).y];
for i=1:length(queenPath)
    %Segun el tipo de nodo se dibujan de un color y estilo diferente
    if graph.node(queenPath(i)).tipo == 0
        plot(X(i),Y(i),'-s','MarkerSize',15,'MarkerEdgeColor','k','MarkerFaceColor','k');
        text(X(i),Y(i),num2str(queenPath(i)),'Color','w','Fontsize',10,'VerticalAlignment','middle','HorizontalAlignment','center');
    elseif graph.node(queenPath(i)).tipo == 1
        plot(X(i),Y(i),'-s','MarkerSize',15,'MarkerEdgeColor','k','MarkerFaceColor','g');
        text(X(i),Y(i),num2str(queenPath(i)),'Fontsize',10,'VerticalAlignment','middle','HorizontalAlignment','center');
    elseif graph.node(queenPath(i)).tipo == 2
        plot(X(i),Y(i),'-p','MarkerSize',15,'MarkerEdgeColor','k','MarkerFaceColor','b');
        text(X(i),Y(i),num2str(queenPath(i)),'Fontsize',10,'VerticalAlignment','cap','HorizontalAlignment','center');
    elseif graph.node(queenPath(i)).tipo == 3
        plot(X(i),Y(i),'-v','MarkerSize',15,'MarkerEdgeColor','k','MarkerFaceColor','r');
        text(X(i),Y(i),num2str(queenPath(i)),'Fontsize',10,'VerticalAlignment','cap','HorizontalAlignment','center');
    end
end

%Ajustamos los límites del gráfico para que se mantengan las escalas entre
%gráficos.
xlim([min([graph.node(:).x])-1 max([graph.node(:).x])+1]);
ylim([min([graph.node(:).y])-1 max([graph.node(:).y])+1]);
title('Mejor recorrido (hormiga reina)');
box('on');
end