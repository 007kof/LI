nat(0).
nat(N) :- nat(N1), N is N1 + 1.

% X = Z = Misionero, Y = W = Canibal

noMatarANadie([X,Y]) :- Z is 3 - X, W is 3 - Y, X >= Y, Z >= W, !.
noMatarANadie([0,_]) :- !.
noMatarANadie([3,_]).

transportarDerecha([[X,Y1],[Z,W1]],[[X,Y2],[Z,W2]]) :- Y2 is Y1 - 1, W2 is W1 + 1, between(0,3,Y2), between(0,3,W2).
transportarDerecha([[X,Y1],[Z,W1]],[[X,Y2],[Z,W2]]) :- Y2 is Y1 - 2, W2 is W1 + 2, between(0,3,Y2), between(0,3,W2).
transportarDerecha([[X1,Y],[Z1,W]],[[X2,Y],[Z2,W]]) :- X2 is X1 - 1, Z2 is Z1 + 1, between(0,3,X2), between(0,3,Z2).
transportarDerecha([[X1,Y],[Z1,W]],[[X2,Y],[Z2,W]]) :- X2 is X1 - 2, Z2 is Z1 + 2, between(0,3,X2), between(0,3,Z2).
transportarDerecha([[X1,Y1],[Z1,W1]],[[X2,Y2],[Z2,W2]]) :- X2 is X1 - 1, Y2 is Y1 - 1, Z2 is Z1 + 1, W2 is W1 + 1, between(0,3,X2), between(0,3,Y2), between(0,3,Z2), between(0,3,W2).

transportarIzquierda([[X,Y1],[Z,W1]],[[X,Y2],[Z,W2]]) :- Y2 is Y1 + 1, W2 is W1 - 1, between(0,3,Y2), between(0,3,W2).
transportarIzquierda([[X,Y1],[Z,W1]],[[X,Y2],[Z,W2]]) :- Y2 is Y1 + 2, W2 is W1 - 2, between(0,3,Y2), between(0,3,W2).
transportarIzquierda([[X1,Y],[Z1,W]],[[X2,Y],[Z2,W]]) :- X2 is X1 + 1, Z2 is Z1 - 1, between(0,3,X2), between(0,3,Z2).
transportarIzquierda([[X1,Y],[Z1,W]],[[X2,Y],[Z2,W]]) :- X2 is X1 + 2, Z2 is Z1 - 2, between(0,3,X2), between(0,3,Z2).
transportarIzquierda([[X1,Y1],[Z1,W1]],[[X2,Y2],[Z2,W2]]) :- X2 is X1 + 1, Y2 is Y1 + 1, Z2 is Z1 - 1, W2 is W1 - 1, between(0,3,X2), between(0,3,Y2), between(0,3,Z2), between(0,3,W2).

transportar([X,Y,false],[W,Z,true]) :- transportarDerecha([X,Y], [W,Z]), noMatarANadie(W).
transportar([X,Y,true],[W,Z,false]) :- transportarIzquierda([X,Y], [W,Z]), noMatarANadie(W).

unPaso(EA,ES) :- transportar(EA,ES).

camino(E,E,C,C).
camino(EA,EF,CHA,CT) :- unPaso(EA,ES), \+member(ES,CHA), camino(ES,EF,[ES|CHA],CT).

misioneros :- nat(N), camino([[3,3],[0,0],false],[[0,0],[3,3],_],[[[3,3],[0,0],false]],C), length(C,N), write(C), write(" "), write(N), !.
