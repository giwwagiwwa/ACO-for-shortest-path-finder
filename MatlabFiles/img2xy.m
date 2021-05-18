function [puntos,moves] = img2xy(color_inici,color_final,img_name)
%Transforma mapa de bits en puntos xy del mapa y matriz moves
%Cargar la imagen en bmp
rutaimg = strcat('./mapas/',img_name);
%Leemos la imagen del archivo
imagen_mapa = imread(rutaimg);
% %Rotamos la imagen 180 para que en el for de check de bits empiece por
% %abajo
% imagen_mapa = imrotate(imagen_mapa,180);
% %Volteamos horizontalmente para que empiece de derecha a izquierda
% imagen_mapa = imagen_mapa(:,end:-1:1,:);
[altura,anchura,~] = size(imagen_mapa);
%variables de posicion que luego se sustituyen
x(1) = -1;
y(1) = -1;
%matriz moves que contiene las restricciones de desplazamiento entre nodos
moves = zeros(altura*anchura,altura*anchura);
%matriz que contiene los indices de los nodos, mismo tamaño que moves.
mat_numnodes = zeros(altura,anchura);
%Indices a apuntar al final
mat_indices = zeros(altura*anchura,4); %maximo se puede desplazar a 4 puntos al lado
contador_nodes = 1;
%rellenar matriz de num nodos
for i=altura:-1:1
    for j=1:1:anchura
        mat_numnodes(i,j) = contador_nodes;
        contador_nodes = contador_nodes +1;
    end
end
num_node = 1;
%variable que señala si hemos descubierto un nuevo punto
nuevopunto = 0;
%extrear puntos del bitmap
for i=altura:-1:1
    for j=1:anchura
        %comprovar si es inicio
        if (imagen_mapa(i,j,1) == color_inici(1)) & (imagen_mapa(i,j,2) == color_inici(2)) & (imagen_mapa(i,j,3) == color_inici(3))
            %si es igual es el nodo inicio:
            nuevopunto = 3;
        %comprovamos si es nodo final
        elseif (imagen_mapa(i,j,1) == color_final(1)) & (imagen_mapa(i,j,2) == color_final(2)) & (imagen_mapa(i,j,3) == color_final(3))
            nuevopunto = 2;
        %sino comprovamos si son blancos (255,255,255) y rellenamos los
        %puntos x y
        elseif imagen_mapa(i,j,:) == [255,255,255]
            nuevopunto = 1;
        end
        %Cuando detectamos un punto miramos a cuales se puede mover
        %alrededor:
        %posible movimiento abajo
        %Para añadir a la matriz moves el punto debe ser blanco/inicio/fin
        if nuevopunto > 0
            %Posible movimiento Arriba
            if i>1
                if imagen_mapa(i-1,j,:) == [255,255,255] | (imagen_mapa(i-1,j,1) == color_final(1)) & (imagen_mapa(i-1,j,2) == color_final(2)) & (imagen_mapa(i-1,j,3) == color_final(3))
                    mat_indices(num_node,1) = mat_numnodes(i-1,j);
                else
                    mat_indices(num_node,1) = 0;
                end
            else
                mat_indices(num_node,1) = 0;
            end
            %posible movimiento izquierda
            if j>1
                if imagen_mapa(i,j-1,:) == [255,255,255] | (imagen_mapa(i,j-1,1) == color_final(1)) & (imagen_mapa(i,j-1,2) == color_final(2)) & (imagen_mapa(i,j-1,3) == color_final(3))
                    mat_indices(num_node,2) = mat_numnodes(i,j-1);
                else
                    mat_indices(num_node,2) = 0;
                end
            else
                mat_indices(num_node,2) = 0;
            end
            %posible movimiento derecha
            if j<anchura
                if imagen_mapa(i,j+1,:) == [255,255,255] | (imagen_mapa(i,j+1,1) == color_final(1)) & (imagen_mapa(i,j+1,2) == color_final(2)) & (imagen_mapa(i,j+1,3) == color_final(3))
                    mat_indices(num_node,3) = mat_numnodes(i,j+1);
                else
                    mat_indices(num_node,3) = 0;
                end
            else
                mat_indices(num_node,3) = 0;
            end
            %posible movimiento abajo
            if i<altura
                if imagen_mapa(i+1,j,:) == [255,255,255] | (imagen_mapa(i+1,j,1) == color_final(1)) & (imagen_mapa(i+1,j,2) == color_final(2)) & (imagen_mapa(i+1,j,3) == color_final(3))
                    mat_indices(num_node,4) = mat_numnodes(i+1,j);
                else
                    mat_indices(num_node,4) = 0;
                end
            else
                mat_indices(num_node,4) = 0;
            end
        else
            %Si es negro la fila de moves = 0
            moves(num_node,:) = 0;
        end
        %Añadimos el punto, su tipo
        puntos(num_node).x = j;
        puntos(num_node).y = i;
        puntos(num_node).tipo = nuevopunto;
        num_node = num_node + 1;
        nuevopunto = 0;
    end
end
%Cuando tenemos los puntos y los nodos a los que se puede mover cada uno,
%rellenamos la matriz moves
for i=1:altura*anchura
    for j=1:4
        %comprueba si el nodo i se puede mover a algun destino
       if mat_indices(i,j) ~= 0
           %Si se puede mover cogemos el numero de nodo y marcamos 1 como
           %que se puede desplazar
           %Limitamos que solo permita movimiento para adelante:
           %if mat_indices(i,j)> i
            moves(i,mat_indices(i,j)) = 1;
           %end
       end
    end
end

