programa([begin|L]) :- ultimo(L,end), select(end,L,R), !, instrucciones(R).

instrucciones(L) :- instruccion(L), !.
instrucciones(L) :- append(L1,[;|L2],L), instruccion(L1), instrucciones(L2), !.

instruccion([X,=,Y,+,Z]) :- variable(X), variable(Y), variable(Z), !.
instruccion(L) :- append([if,X,=,Y,then],L1,L), append(L2,[else|L3],L1), ultimo(L3,endif), select(endif,L3,L4), !, variable(X), variable(Y), instrucciones(L2), instrucciones(L4).

variable(x).
variable(y).
variable(z).

ultimo(L,X) :- append(_,[X],L), !.
