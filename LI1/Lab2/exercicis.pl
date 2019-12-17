%Funciones.
size([], 0) :- !.
size([_|L], R) :- size(L, R1), R is R1 + 1.

my_suma([], 0).
my_suma([X|L], S) :- my_suma(L, S1), S is S1 + X.

pert(X, [X|_]).
pert(X, [_|L]) :- pert(X, L).

pert_con_resto(X, L, R) :- concat(L1, [X|L2], L), concat(L1, L2, R).

buscar(X, [X|_]) :- !.
buscar(X, [_|L]) :- buscar(X, L).

concat([], L, L).
concat([X|L1], L2, [X|L3]) :- concat(L1, L2, L3).

my_long([], 0).
my_long([_|L], S) :- my_long(L, S1), S is S1 + 1.

my_subconjunto([], []).
my_subconjunto([X|L], [X|S]) :- my_subconjunto(L, S).
my_subconjunto([_|L], S) :- my_subconjunto(L, S).

my_permutacion([], []).
my_permutacion(L, [X|P]) :- pert_con_resto(X, L, R), my_permutacion(R, P).

%2.
prod([], 1).
prod([X|L], P) :- prod(L, P1), P is P1 * X.

%3.
pescalar([], [], 0).
pescalar([X|L1], [Y|L2], P) :- pescalar(L1, L2, P1), P is P1 + (X * Y).

%4.
interseccion([], _, []).
interseccion([X|L1], L2, [X|L3]) :- buscar(X, L2), !, interseccion(L1, L2, L3).
interseccion([_|L1], L2, L3) :- interseccion(L1, L2, L3).

my_union([], L, L).
my_union([X|L1], L2, [X|L3]) :- not(buscar(X, L2)), my_union(L1, L2, L3).

%5.
my_ultimo(L, X) :- concat(_, [X], L).

my_inverso([], []).
my_inverso([X|L], R) :- my_inverso(L, L1), concat(L1, [X], R).

%6.
my_fib(0, 0) :- !.
my_fib(1, 1) :- !.
my_fib(N, F) :- N1 is N-1, my_fib(N1, F1), N2 is N-2, my_fib(N2, F2), F is F1 + F2.

%7.
my_dados(_, 0, []) :- !.
my_dados(P, N, [X|L]) :- pert(X, [1, 2, 3, 4, 5, 6]), N1 is N-1, P1 is P-X, my_dados(P1, N1, L), my_suma(L, P1).

%8.
my_suma_demas([0]) :- !.
my_suma_demas(L) :- pert_con_resto(X, L, R), my_suma(R, X), !.

%9.
lista_ants(X, L, A) :- concat(A, [X|_], L).

my_suma_ants([0]) :- !.
my_suma_ants(L) :- lista_ants(X, L, A), my_suma(A, X), !.

%10.
my_cont([], _, 0).
my_cont([X|L], X, N) :- !, my_cont(L, X, N1), N is N1 + 1.
my_cont([_|L], X, N) :- my_cont(L, X, N1), N is N1.

my_erase([], _, []).
my_erase([X|L], X, R) :- !, my_erase(L, X, R).
my_erase([Y|L], X, R) :- my_erase(L, X, R1), concat([Y], R1, R).

my_card(L) :- my_card_aux(L, R), write(R).

my_card_aux([], []).
my_card_aux([X|L], R) :- my_cont([X|L], X, N), my_erase([X|L], X, R1), my_card_aux(R1, R2), concat([[X, N]], R2, R).

%11.
my_esta_ordenada() :- !.
my_esta_ordenada([_]) :- !.
my_esta_ordenada([X,Y|L]) :- X =< Y, my_esta_ordenada([Y|L]).

%12.
my_ordenacion_permutacion(L, R) :- my_permutacion(L, R), my_esta_ordenada(R), !.

%13.
%coste = n!

%14.
my_insercion(X, [], [X]) :- !.
my_insercion(X, [Y|L], R) :- X =< Y, concat([X], [Y|L], R), !.
my_insercion(X, [Y|L], R) :- my_insercion(X, L, R1), concat([Y], R1, R).

my_ordenacion_insert([], []).
my_ordenacion_insert([X|L], R) :- my_ordenacion_insert(L, R1), my_insercion(X, R1, R).

%15.
%numero de comparaciones = n^2

%16.
my_divide([], [], []).
my_divide([X], [], [X]).
my_divide([X|L1], [Y|L2], [X,Y|L]) :- my_divide(L1, L2, L), !.

my_merge([], [], []) :- !.
my_merge(L, [], L) :- !.
my_merge([], L, L) :- !.
my_merge([X|L1], [Y|L2], [Y|L]) :- X >= Y, my_merge([X|L1], L2, L), !.
my_merge([X|L1], [Y|L2], [X|L]) :- my_merge(L1, [Y|L2], L).

my_ordenacion_merge([], []) :- !.
my_ordenacion_merge([X], [X]) :- !.
my_ordenacion_merge(L, R) :- my_divide(L1, L2, L), my_ordenacion_merge(L1, R1), my_ordenacion_merge(L2, R2), my_merge(R1, R2, R).

%17.
my_escribir([]) :- write(' ').
my_escribir([X|R]) :- write(X), my_escribir(R).

my_diccionario(A, N) :- my_diccionario_aux(A, N, R), my_escribir(R), fail.

my_diccionario_aux(_, 0, []) :- !.
my_diccionario_aux(A, N, [X|R]) :- pert(X, A), N1 is N - 1, my_diccionario_aux(A, N1, R).

%18.
my_palindromo(L) :- setof(R, my_palindromo_aux(L, R), S), write(S).

es_palindromo(L) :- my_inverso(L, R), L = R.

my_palindromo_aux([], []).
my_palindromo_aux(L, R) :- my_permutacion(L, R), es_palindromo(R).
