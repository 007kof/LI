%2
prod([],1).
prod([X|L],P) :- prod(L,P1), P is P1 * X.

%3
pescalar([],[],0).
pescalar([X|L1],[Y|L2],P) :- pescalar(L1,L2,P1), P is P1 + X * Y.

%4
interseccion([],_,[]).
interseccion([X|L1],L2,[X|R]) :- member(X,L2), !, interseccion(L1,L2,R).
interseccion([_|L1],L2,R) :- interseccion(L1,L2,R).

myunion(L,[],L) :- !.
myunion([],L,L) :- !.
myunion([X|L1],L2,[X|R]) :- \+member(X,L2), !, myunion(L1,L2,R).
myunion([_|L1],L2,R) :- myunion(L1,L2,R).

%5
ultimo(L,X) :- append(_,[X],L), !.

inverso([],[]).
inverso([X|L],R) :- inverso(L,R1), append(R1,[X],R).

%6
fib(1,1) :- !.
fib(2,1) :- !.
fib(N,F) :- N1 is N-1, fib(N1,F1), N2 is N1-1, fib(N2,F2), F is F1 + F2.

%7
dados(_,0,[]) :- !.
dados(P,N,[X|L]) :- between(1,6,X), P1 is P-X, N1 is N-1, dados(P1,N1,L), suma(P,[X|L]).

suma(0,[]).
suma(S,[X|L]) :- suma(S1,L), S is S1 + X.

%8
suma_demas(L) :- select(X,L,R), suma(X,R), !.

%9
suma_ants(L) :- suma_ants_aux([],L).

suma_ants_aux(L, [X|_]) :- suma(X,L), !.
suma_ants_aux(L, [X|R]) :- suma_ants_aux([X|L],R).

%10.
card(L) :- card_aux(L,R), write(R).

card_aux([],[]).
card_aux([X|L],[[X,C]|R]) :- count(X,[X|L],C), erase(X,[X|L],L1), card_aux(L1,R).

count(_,[],0).
count(X,[X|L],C) :- count(X,L,C1), C is C1 + 1, !.
count(X,[_|L],C) :- count(X,L,C), !.

erase(_,[],[]).
erase(X,[X|L],R) :- erase(X,L,R), !.
erase(X,[Y|L],R) :- erase(X,L,R1), append([Y],R1,R), !.

%11.
esta_ordenada([]) :- !.
esta_ordenada([_]) :- !.
esta_ordenada([X,Y|L]) :- X =< Y, esta_ordenada([Y|L]).

%12.
ordenacion([],[]) :- !.
ordenacion(L1,L2) :- permutation(L1,L2), esta_ordenada(L2), !.

%13.
%n!

%14.
insercion(X,[],[X]).
insercion(X,[Y|L],[X,Y|L]) :- X =< Y, !.
insercion(X,[Y|L],L1) :- insercion(X,L,L2), append([Y],L2,L1), !.

ordenacion_insercion([],[]) :- !.
ordenacion_insercion([X|L1],L2) :- ordenacion_insercion(L1,R), insercion(X,R,L2), !.

%15.
%n^2

%16.
divide([],[],[]) :- !.
divide(L,R1,R2) :- length(L,N), N1 is N//2, N2 is N - N1, take(N1,L,R1), append(R1,Raux,L), take(N2,Raux,R2).

take(0,_,[]) :- !.
take(N,[X|L],[X|R]) :- N > 0, N1 is N - 1, take(N1,L,R).

merge([],X,X) :- !.
merge(X,[],X) :- !.
merge([X|L1],[Y|L2],[X|R]) :- X =< Y, merge(L1,[Y|L2],R), !.
merge([X|L1],[Y|L2],[Y|R]) :- merge([X|L1],L2,R).

ordenacion_merge([],[]) :- !.
ordenacion_merge([X],[X]) :- !.
ordenacion_merge(L1,L2) :- divide(L1,R1,R2), ordenacion_merge(R1,RL), ordenacion_merge(R2,RR), merge(RL,RR,L2).

%17.
diccionario(A,N) :- diccionario_aux(A,N,L), escribir(L), nl, fail.

diccionario_aux(_,0,[]) :- !.
diccionario_aux(L,N,R) :- N1 is N - 1, diccionario_aux(L,N1,R1), member(X,L), append(R1,[X],R).

escribir([]).
escribir([X|L]) :- write(X), escribir(L).

%18.
%palindromos(L) :- permutation(L,R), is_palindrom(R), write(R), nl ,fail.
palindromos(L) :- setof(R, (permutation(L,R), is_palindrom(R)), S), write(S).

is_palindrom([]).
is_palindrom([_]) :- !.
is_palindrom([X|L]) :- append(L1,[X],L), !, is_palindrom(L1).

%19.
%letterM(M) :- between(0, 1, M).
%letterS(S) :- between(0, 9, S).
%letterE(E) :- between(0, 9, E).
%letterN(N) :- between(0, 9, N).
%letterD(D) :- between(0, 9, D).
%letterO(O) :- between(0, 9, O).
%letterR(R) :- between(0, 9, R).
%letterY(Y) :- between(0, 9, Y).
allPossibleValues([0,1,2,3,4,5,6,7,8,9]).

send_more_money :- allPossibleValues(L), select(S,L,L1), select(E,L1,L2), select(N,L2,L3), select(D,L3,L4), select(M,[0,1],_), select(O,L4,L5), select(R,L5,L6), select(Y,L6,_), \+someLetterEquals([S,E,N,D,M,O,R,Y]), sum_restriction([0,S,E,N,D],[0,M,O,R,E],[M,O,N,E,Y],0), write_solution(S,E,N,D,M,O,R,Y), nl, nl, fail.

sum_restriction([X],[Y],[Z],Carry) :- Carry is (X + Y) // 10, Z is (X + Y) mod 10, !.
sum_restriction([X|L1],[Y|L2],[Z|L3],Carry) :- sum_restriction(L1,L2,L3,Carry1), Carry is (X + Y) // 10, Z is (X + Y + Carry1) mod 10.

write_solution(S,E,N,D,M,O,R,Y) :- write("S = "), write(S), nl, write("E = "), write(E), nl, write("N = "), write(N), nl, write("D = "), write(D), nl, write("M = "), write(M), nl, write("O = "), write(O), nl, write("R = "), write(R), nl, write("Y = "), write(Y), nl, write("  "), write(S-E-N-D), nl, write("+ "), write(M-O-R-E), nl, write("---------"), nl, write(M-O-N-E-Y).

someLetterEquals([]) :- fail, !.
someLetterEquals([_]) :- fail, !.
someLetterEquals(L) :- select(X,L,R), member(Value,R), X = Value, !.
