nat(0).
nat(N) :- nat(N1), N is N1 + 1.

firstIsland([X,_,_],X).

secondIsland([_,Y,_],Y).

boatPosicion([_,_,Z],Z).

getMisioneros([X,_],X).

getCanibales([_,Y],Y).

correctTravel(Mis1,_,Mis2,_) :- Mis1 is 0, Mis2 is 0, !.
correctTravel(Mis1,_,_,Can2) :- Mis1 is 0, Can2 is 0, !.
correctTravel(Mis1,_,Mis2,Can2) :- Mis1 is 0, Mis2 >= Can2, !.
correctTravel(_,Can1,Mis2,_) :- Can1 is 0, Mis2 is 0, !.
correctTravel(_,Can1,_,Can2) :- Can1 is 0, Can2 is 0, !.
correctTravel(_,Can1,Mis2,Can2) :- Can1 is 0, Mis2 >= Can2, !.
correctTravel(Mis1,Can1,Mis2,_) :- Mis1 >= Can1, Mis2 is 0, !.
correctTravel(Mis1,Can1,_,Can2) :- Mis1 >= Can1, Can2 is 0, !.
correctTravel(Mis1,Can1,Mis2,Can2) :- Mis1 >= Can1, Mis2 >= Can2, !.


compatible(Isla1,Isla2) :- getMisioneros(Isla1,Mis1), getCanibales(Isla1,Can1), getMisioneros(Isla2,Mis2), getCanibales(Isla2,Can2), Mis1 >= 0, Can1 >= 0, Mis2 >= 0, Can2 >= 0, Total is Mis1 + Mis2 + Can1 + Can2, Total is 6, correctTravel(Mis1,Can1,Mis2,Can2).

travelLeftToRight(Isla1,Isla2,Isla1F,Isla2F) :- getMisioneros(Isla1,Mis1), getMisioneros(Isla2,Mis2), getCanibales(Isla1,Can1), getCanibales(Isla2,Can2), Mis1F is Mis1 - 2, Mis2F is Mis2 + 2, getMisioneros(Isla1F,Mis1F), getMisioneros(Isla2F,Mis2F), getCanibales(Isla1F,Can1), getCanibales(Isla2F,Can2).
travelLeftToRight(Isla1,Isla2,Isla1F,Isla2F) :- getMisioneros(Isla1,Mis1), getMisioneros(Isla2,Mis2), getCanibales(Isla1,Can1), getCanibales(Isla2,Can2), Can1F is Can1 - 2, Can2F is Can2 + 2, getMisioneros(Isla1F,Mis1), getMisioneros(Isla2F,Mis2), getCanibales(Isla1F,Can1F), getCanibales(Isla2F,Can2F).
travelLeftToRight(Isla1,Isla2,Isla1F,Isla2F) :- getMisioneros(Isla1,Mis1), getMisioneros(Isla2,Mis2), getCanibales(Isla1,Can1), getCanibales(Isla2,Can2), Mis1F is Mis1 - 1, Mis2F is Mis2 + 1, Can1F is Can1 - 1, Can2F is Can2 + 1, getMisioneros(Isla1F,Mis1F), getMisioneros(Isla2F,Mis2F), getCanibales(Isla1F,Can1F), getCanibales(Isla2F,Can2F).
travelLeftToRight(Isla1,Isla2,Isla1F,Isla2F) :- getMisioneros(Isla1,Mis1), getMisioneros(Isla2,Mis2), getCanibales(Isla1,Can1), getCanibales(Isla2,Can2), Mis1F is Mis1 - 1, Mis2F is Mis2 + 1, getMisioneros(Isla1F,Mis1F), getMisioneros(Isla2F,Mis2F), getCanibales(Isla1F,Can1), getCanibales(Isla2F,Can2).
travelLeftToRight(Isla1,Isla2,Isla1F,Isla2F) :- getMisioneros(Isla1,Mis1), getMisioneros(Isla2,Mis2), getCanibales(Isla1,Can1), getCanibales(Isla2,Can2), Can1F is Can1 - 1, Can2F is Can2 + 1, getMisioneros(Isla1F,Mis1), getMisioneros(Isla2F,Mis2), getCanibales(Isla1F,Can1F), getCanibales(Isla2F,Can2F).

travelRightToLeft(Isla1,Isla2,Isla1F,Isla2F) :- getMisioneros(Isla1,Mis1), getMisioneros(Isla2,Mis2), getCanibales(Isla1,Can1), getCanibales(Isla2,Can2), Mis1F is Mis1 + 2, Mis2F is Mis2 - 2, getMisioneros(Isla1F,Mis1F), getMisioneros(Isla2F,Mis2F), getCanibales(Isla1F,Can1), getCanibales(Isla2F,Can2).
travelRightToLeft(Isla1,Isla2,Isla1F,Isla2F) :- getMisioneros(Isla1,Mis1), getMisioneros(Isla2,Mis2), getCanibales(Isla1,Can1), getCanibales(Isla2,Can2), Can1F is Can1 + 2, Can2F is Can2 - 2, getMisioneros(Isla1F,Mis1), getMisioneros(Isla2F,Mis2), getCanibales(Isla1F,Can1F), getCanibales(Isla2F,Can2F).
travelRightToLeft(Isla1,Isla2,Isla1F,Isla2F) :- getMisioneros(Isla1,Mis1), getMisioneros(Isla2,Mis2), getCanibales(Isla1,Can1), getCanibales(Isla2,Can2), Mis1F is Mis1 + 1, Mis2F is Mis2 - 1, Can1F is Can1 + 1, Can2F is Can2 - 1, getMisioneros(Isla1F,Mis1F), getMisioneros(Isla2F,Mis2F), getCanibales(Isla1F,Can1F), getCanibales(Isla2F,Can2F).
travelRightToLeft(Isla1,Isla2,Isla1F,Isla2F) :- getMisioneros(Isla1,Mis1), getMisioneros(Isla2,Mis2), getCanibales(Isla1,Can1), getCanibales(Isla2,Can2), Mis1F is Mis1 + 1, Mis2F is Mis2 - 1, getMisioneros(Isla1F,Mis1F), getMisioneros(Isla2F,Mis2F), getCanibales(Isla1F,Can1), getCanibales(Isla2F,Can2).
travelRightToLeft(Isla1,Isla2,Isla1F,Isla2F) :- getMisioneros(Isla1,Mis1), getMisioneros(Isla2,Mis2), getCanibales(Isla1,Can1), getCanibales(Isla2,Can2), Can1F is Can1 + 1, Can2F is Can2 - 1, getMisioneros(Isla1F,Mis1), getMisioneros(Isla2F,Mis2), getCanibales(Isla1F,Can1F), getCanibales(Isla2F,Can2F).

unPaso(EstadoActual, EstSiguiente) :- firstIsland(EstadoActual,Isla1), secondIsland(EstadoActual,Isla2), boatPosicion(EstadoActual,Boat), Boat = false, travelLeftToRight(Isla1,Isla2,Isla1F,Isla2F), compatible(Isla1,Isla2), compatible(Isla1F,Isla2F), firstIsland(EstSiguiente,Isla1F), secondIsland(EstSiguiente,Isla2F), boatPosicion(EstSiguiente,true).

unPaso(EstadoActual, EstSiguiente) :- firstIsland(EstadoActual,Isla1), secondIsland(EstadoActual,Isla2), boatPosicion(EstadoActual,Boat), Boat = true, travelRightToLeft(Isla1,Isla2,Isla1F,Isla2F), compatible(Isla1,Isla2), compatible(Isla1F,Isla2F), firstIsland(EstSiguiente,Isla1F), secondIsland(EstSiguiente,Isla2F), boatPosicion(EstSiguiente,false).

camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
    unPaso(EstadoActual,EstSiguiente),
    \+member(EstSiguiente,CaminoHastaAhora),
    camino(EstSiguiente,EstadoFinal,[EstSiguiente|CaminoHastaAhora],CaminoTotal).

solucionOptima :-
    nat(N),
    camino([[3,3],[0,0],false],[[0,0],[3,3],_],[[[3,3],[0,0],false]],C),
    length(C,N),
    reverse(C,C1),
    write(C1),
    write(" "),
    write(N),
    nl,
    !.
