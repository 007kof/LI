nat(0).
nat(N) :- nat(N1), N is N1 + 1.

llenarCubo5([_,Y],[5,Y]).
llenarCubo8([X,_],[X,8]).
vaciarCubo5([_,Y],[0,Y]).
vaciarCubo8([X,_],[X,0]).
verterCubo5aCubo8([X,Y],[0,Z]) :- X + Y =< 8, Z is X + Y, !.
verterCubo5aCubo8([X,Y],[Z,8]) :- Z is X+Y-8, Z >= 0.
verterCubo8aCubo5([X,Y],[Z,0]) :- X + Y =< 5, Z is X + Y, !.
verterCubo8aCubo5([X,Y],[5,Z]) :- Z is X+Y-5, Z >= 0.

unPaso([X,Y],ES) :- X < 5, llenarCubo5([X,Y],ES).
unPaso([X,Y],ES) :- Y < 8, llenarCubo8([X,Y],ES).
unPaso([X,Y],ES) :- X > 0, vaciarCubo5([X,Y],ES).
unPaso([X,Y],ES) :- Y > 0, vaciarCubo8([X,Y],ES).
unPaso([X,Y],ES) :- X > 0, verterCubo5aCubo8([X,Y],ES).
unPaso([X,Y],ES) :- Y > 0, verterCubo8aCubo5([X,Y],ES).

camino(E,E,C,C).
camino(EA,EF,CHA,CT) :- unPaso(EA,ES), \+member(ES,CHA), camino(ES,EF,[ES|CHA],CT).

water :- nat(N), camino([0,0],[0,4],[[0,0]],C), length(C,N), !, write(C), write(" "), write(N).
