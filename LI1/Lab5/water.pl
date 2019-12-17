first(X,[X,_]).

second(Y,[_,Y]).

nat(0).
nat(N) :- nat(N1), N is N1 + 1.

verter(Cubo5,Cubo8,Cubo5v,Cubo8v) :- Cubo5 > 0, Cubo8 < 8, Cubo8 + Cubo5 =< 8, Cubo5v is 0, Cubo8v is Cubo8 + Cubo5.
verter(Cubo5,Cubo8,Cubo5v,Cubo8v) :- Cubo5 > 0, Cubo8 + Cubo5 > 8, Cubo is 8 - Cubo8, Cubo5v is Cubo5 - Cubo, Cubo8v is 8.
verter(Cubo5,Cubo8,Cubo5v,Cubo8v) :- Cubo8 > 0, Cubo5 < 5, Cubo5 + Cubo8 =< 5, Cubo5v is Cubo5 + Cubo8, Cubo8v is 0.
verter(Cubo5,Cubo8,Cubo5v,Cubo8v) :- Cubo8 > 0, Cubo8 + Cubo5 > 5, Cubo is 5 - Cubo5, Cubo5v is 5, Cubo8v is Cubo8 - Cubo.

unPaso(EstadoActual,EstSiguiente) :- first(Cubo5,EstadoActual), second(Cubo8,EstadoActual), Cubo5 is 0, first(5,EstSiguiente), second(Cubo8,EstSiguiente).
unPaso(EstadoActual,EstSiguiente) :- first(Cubo5,EstadoActual), second(Cubo8,EstadoActual), not(Cubo5 is 0), first(0,EstSiguiente), second(Cubo8,EstSiguiente).
unPaso(EstadoActual,EstSiguiente) :- first(Cubo5,EstadoActual), second(Cubo8,EstadoActual), Cubo8 is 0, first(Cubo5,EstSiguiente), second(8,EstSiguiente).
unPaso(EstadoActual,EstSiguiente) :- first(Cubo5,EstadoActual), second(Cubo8,EstadoActual), not(Cubo8 is 0), first(Cubo5,EstSiguiente), second(0,EstSiguiente).
unPaso(EstadoActual,EstSiguiente) :- first(Cubo5,EstadoActual), second(Cubo8,EstadoActual), verter(Cubo5,Cubo8,Cubo5v,Cubo8v), first(Cubo5v,EstSiguiente), second(Cubo8v,EstSiguiente).


camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
    unPaso(EstadoActual,EstSiguiente),
    \+member(EstSiguiente,CaminoHastaAhora),
    camino(EstSiguiente,EstadoFinal,[EstSiguiente|CaminoHastaAhora],CaminoTotal).

solucionOptima :-
    nat(N),
    camino([0,0],[4,5],[[0,0]],C),
    length(C,N),
    reverse(C,C1),
    write(C1),
    nl,
    !.
