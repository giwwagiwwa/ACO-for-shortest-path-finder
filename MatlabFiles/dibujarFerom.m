function [] = dibujarFerom( tau, graph )
%Función para representar los niveles de feromonas entre todos los puntos
%del gráfico.

%Para determinar los niveles de feromonas a dibujar, hay que conocer el
%nivel mínimo y máximo presente en el gráfico.
maxTau = max(tau(:));
minTau = min(tau(:));
hold on;
%Normalizar entre 0 y 1 (restricción de matlab)
tau_norm = (tau-minTau)/(maxTau-minTau);

%Plotear
for i=1:graph.n-1
    for j=i+1:graph.n
        x1 = graph.node(i).x;
        y1 = graph.node(i).y;
        
        x2 = graph.node(j).x;
        y2 = graph.node(j).y;
        
        X = [x1, x2];
        Y = [y1, y2];
        
        %Para pintar el color (RGB) usamos tau normalizada:
        %Tambien hay que cambiar el tamaño de la línea en función de tau
        %de 1 a 11 en función de tau.
        %[Red, Green, Blue, Transparencia]
        plot(X,Y, 'color', [0,0,1-tau_norm(i,j), tau_norm(i,j)], 'lineWidth',10.*tau_norm(i,j)+1);
    end
end
    X = [graph.node(:).x];
    Y = [graph.node(:).y];
for i=1:graph.n
if graph.node(i).tipo == 0
        plot(X(i),Y(i),'-s','MarkerSize',15,'MarkerEdgeColor','k','MarkerFaceColor','k');
        text(X(i),Y(i),num2str(i),'Color','w','Fontsize',10,'VerticalAlignment','middle','HorizontalAlignment','center');
    elseif graph.node(i).tipo == 1
        plot(X(i),Y(i),'-s','MarkerSize',15,'MarkerEdgeColor','k','MarkerFaceColor','g');
        text(X(i),Y(i),num2str(i),'Fontsize',10,'VerticalAlignment','middle','HorizontalAlignment','center');
    elseif graph.node(i).tipo == 2
        plot(X(i),Y(i),'-p','MarkerSize',15,'MarkerEdgeColor','k','MarkerFaceColor','b');
        text(X(i),Y(i),num2str(i),'Fontsize',10,'VerticalAlignment','cap','HorizontalAlignment','center');
    elseif graph.node(i).tipo == 3
        plot(X(i),Y(i),'-v','MarkerSize',15,'MarkerEdgeColor','k','MarkerFaceColor','r');
        text(X(i),Y(i),num2str(i),'Fontsize',10,'VerticalAlignment','cap','HorizontalAlignment','center');
    end
end

title('Niveles de feromona');
box('on');

end