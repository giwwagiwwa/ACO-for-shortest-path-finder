function [X,Y,moves] = generaMapaNodes(mapaselect)
%Obtiene las coordenadas X y Y de cada nodo de los tres mapas predefinidos.
%También se construye la matriz moves manualmente.

if mapaselect == 1
%MAP 1:
X = [2,2,3,4,5,7,8,9,10,11,11,12,14,14,15,15];
Y = [1,7,14,10,5,8,12,3,8,11,14,7,11,15,2,8];
moves = [
   %1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6
    0 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0;
    0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 1 0 0 0 1 0 0 0 0 0;
    0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 1 0 1 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 1 1 1 0 0 0 0 0;
    0 0 0 0 0 0 0 0 1 0 0 1 0 0 1 0;
    0 0 0 0 0 0 0 1 0 1 0 1 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
elseif mapaselect == 2
%MAP 2
X = [10,1,2,3,4,4,5,5,6,6,6,8,8,9,10,12,12,13,14,14,15,16,17,17,19,19,10];
Y = [1,10,21,16,4,12,8,22,1,15,19,5,24,17,12,5,20,9,1,14,22,11,5,17,8,21,24];
moves = zeros(length(X),length(Y));
moves(1,9)=1;moves(1,12)=1;moves(1,16)=1;moves(1,19)=1;
moves(2,3)=1;moves(2,4)=1;
moves(3,8)=1;
moves(4,3)=1;moves(4,11)=1;moves(4,8)=1;
moves(5,2)=1;moves(5,6)=1;
moves(6,4)=1;moves(6,10)=1;
moves(7,6)=1;
moves(8,13)=1;
moves(9,5)=1;moves(9,7)=1;
moves(10,4)=1;moves(10,11)=1;moves(10,14)=1;
moves(11,8)=1;
moves(12,7)=1;moves(12,15)=1;
moves(13,27)=1;
moves(14,11)=1;moves(14,17)=1;
moves(15,14)=1;moves(15,10)=1;moves(15,20)=1;
moves(16,15)=1;moves(16,18)=1;
moves(17,27)=1;
moves(18,22)=1;
moves(19,23)=1;
moves(20,17)=1;moves(20,24)=1;
moves(21,27)=1;moves(21,17)=1;
moves(22,20)=1;moves(22,24)=1;
moves(23,22)=1;moves(23,25)=1;
moves(24,21)=1;moves(24,26)=1;
moves(25,24)=1;moves(25,26)=1;
moves(26,21)=1;
%Map real
elseif mapaselect == 3
X = [14,30,20,14,20,24,30,5,8,2,5,14,24,27,30,1,1,5,26,26,3,5,1,1,5,5,8,8,19,18,13];
Y = [3,6,7,17,17,17,17,3,8,9,17,28,28,28,28,17,24,26,35,43,30,36,36,39,39,44,39,45,35,43,41];

moves = zeros(length(X),length(Y));
moves(1,2)=1;moves(1,3)=1;moves(1,4)=1;moves(1,8)=1;moves(1,9)=1;
moves(2,7)=1;
moves(3,5)=1;
moves(4,5)=1;moves(4,11)=1;moves(4,12)=1;
moves(5,4)=1;moves(5,6)=1;
moves(6,5)=1;moves(6,7)=1;moves(6,13)=1;
moves(7,6)=1;moves(7,15)=1;
moves(8,10)=1;
moves(9,10)=1;
moves(10,9)=1;moves(10,8)=1;moves(10,11)=1;moves(10,16)=1;
moves(11,4)=1;moves(11,10)=1;moves(11,16)=1;moves(11,18)=1;
moves(12,4)=1;moves(12,13)=1;moves(12,18)=1;
moves(13,6)=1;moves(13,14)=1;moves(13,12)=1;
moves(14,19)=1;
moves(15,14)=1;
moves(16,10)=1;moves(16,11)=1;moves(16,17)=1;
moves(17,16)=1;moves(17,18)=1;
moves(18,21)=1;
moves(19,14)=1;moves(19,20)=1;moves(19,29)=1;
moves(20,30)=1;moves(20,19)=1;
moves(21,18)=1;moves(21,22)=1;moves(21,23)=1;
moves(22,21)=1;moves(22,25)=1;
moves(23,21)=1;moves(23,24)=1;
moves(24,23)=1;moves(24,25)=1;moves(24,26)=1;
moves(25,22)=1;moves(25,24)=1;moves(25,26)=1;moves(25,27)=1;
moves(26,28)=1;moves(26,25)=1;moves(26,24)=1;
moves(27,25)=1;moves(27,31)=1;
moves(28,26)=1;moves(28,31)=1;
moves(29,31)=1;moves(29,19)=1;
moves(30,31)=1;moves(30,20)=1;

end
end

