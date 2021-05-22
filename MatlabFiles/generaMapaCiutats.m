function [X,Y,moves,index_inicio,index_fin] = generaMapaCiutats(datos,inicio,fin)
%Obtiene las coordenads X (Longitud) y Y (Latitud) de cada ciudad española
%y su matriz moves de desplazamientos. También los nodos inicio y fin.

%Obtener nodos de inicio y fin según ha introducido el user
for i=1:length(datos)
    if isequal(inicio,datos(i).ciu) %ciudad inicial
        index_inicio = datos(i).id;
    elseif isequal(fin,datos(i).ciu) %ciudad final
        index_fin = datos(i).id;
    end
end

%matriz moves
moves = zeros(length(datos),length(datos));
for i=1:length(datos)
    %Generar coordenadas X Y para cada población
    X(i) = datos(i).lon;
    Y(i) = datos(i).lat;
    moves(i,datos(i).moves) = 1;
end


end

