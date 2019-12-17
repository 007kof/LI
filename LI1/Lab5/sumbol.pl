variable(x).
variable(y).
variable(z).

programa([begin|L]) :- append(L1, [end], L), instrucciones(L1), !.

instrucciones(L) :- instruccion(L).
instrucciones(L) :- append(L1, [;|L2], L), instruccion(L1), instrucciones(L2).

empty([]).

instruccion(L) :- append([X], L1, L), variable(X), append([=], L2, L1), append([Y], L3, L2), variable(Y), append([+], L4, L3), append([Z], L5, L4), variable(Z), empty(L5).
instruccion(L) :- append([if], L1, L), append([X], L2, L1), variable(X), append([=], L3, L2), append([Y], L4, L3), variable(Y), append([then], L5, L4), append(L6, [else|L7], L5), instrucciones(L6), append(L8, [endif], L7), instrucciones(L8).
