chain([[]], []).
chain(L, R) :- flip(L, R1), correct(R1), R = R1.

flip([], []).
flip([[X,Y]|L],[[Y,X]|R]) :- flip(L, R).
flip([[X,Y]|L], [[X,Y]|R]) :- flip(L, R).

correct([]).
correct([_]) :- !.
correct([X,Y|L]) :- nth1(2, X, R), nth1(1, Y, R), correct([Y|L]).
