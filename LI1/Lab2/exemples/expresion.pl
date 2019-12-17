expr([X], X).
expr(L, E1 + E2) :-
    append(L1, L2, L),
    L1 \= [], L2 \= [],
    expresion(L1, E1),
    expresion(L2, E2).
expr(L, E1 - E2) :-
    append(L1, L2, L),
    L1 \= [], L2 \= [],
    expresion(L1, E1),
    expresion(L2, E2).
expr(L, E1 * E2) :-
    append(L1, L2, L),
    L1 \= [], L2 \= [],
    expresion(L1, E1),
    expresion(L2, E2).
expr(L, E1 / E2) :-
    append(L1, L2, L),
    L1 \= [], L2 \= [],
    expresion(L1, E1),
    expresion(L2, E2),
    X is E2, X \= 0.
