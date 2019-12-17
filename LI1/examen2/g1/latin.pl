:- use_module(library(clpfd)).

%% Complete the following program latin(Vars) that completes a given Latin
%% square: an NxN matrix, where, as in a Sudoku, ALL rows and columns have ALL
%% the numbers 1..N (but, unlike the sudoku, here there are no 3x3 "blocks").
%% Moreover both diagonals also must have ALL the numbers 1..N (see the example).
%% Example 1 below has two solutions:
%% ?- main.
%%
%% 4 2 1 3 5 
%% 5 1 4 2 3 
%% 2 5 3 1 4 
%% 3 4 2 5 1 
%% 1 3 5 4 2 
%%
%%
%% 5 2 1 3 4 
%% 4 1 5 2 3 
%% 2 4 3 1 5 
%% 3 5 2 4 1 
%% 1 3 4 5 2 
%%
%% true.


example(1,
      [  _,2,_,_,_   ,
         _,_,_,_,_   ,
         _,_,_,_,_   ,
         3,_,_,_,_   ,
         1,3,_,_,2   ] ).


example(2,                      %  Example 2 also has 2 solutions.
      [  _,_,2,_,4,_   ,
         _,1,_,_,_,_   ,
         _,_,_,_,_,2   ,
         3,_,_,_,_,_   ,
         _,_,_,_,_,_   ,
         _,2,_,_,5,_   ] ).


main:- example(_,Vars), latin(Vars), fail.
main.

latin(Vars):-
    length(Vars,NSq),       % NSq should be N^2 for some N
    N is round(sqrt(NSq)),  % square root
    Vars ins 1..N,          % 1. domains
    squareByRows(Vars, SquareByRows, N), % 2. constraints
    transpose(SquareByRows, MT),
    constraints(SquareByRows),
    constraints(MT),
    diagonals(SquareByRows),       %
    !,                      %
    labeling([ff], Vars),          % 3. labeling
    writeSquare(SquareByRows),nl,nl.


squareByRows([], [], _) :- !.
squareByRows(L, [R|M], N) :- takeFirst(L, N, R), append(R, R1, L), squareByRows(R1, M, N).

takeFirst(_, 0, []) :- !.
takeFirst([X|L], N, [X|RL]) :- N1 is N - 1, takeFirst(L, N1, RL).

constraints([]).
constraints([X|L]):- constraints(L), all_different(X).

diagonals( SquareByRows ):-
    diagonal( SquareByRows,  1, D1 ),
    reverse( SquareByRows, MT ), % reverse: reverses a list (built-in swipl predicate)
    diagonal( MT, 1, D2 ),
    all_different(D1),
    all_different(D2).
			  %!.

%% diagonal(SquareByRows,1,D). Given SquareByRows, instantiates D to the list of the diagonal (top-left to bottom-right):
diagonal([],_,[]):-!.
diagonal([Row|M], N, [X|L]):- nth1(N,Row,X), N1 is N + 1, diagonal(M, N1, L),!.
						   						   

writeSquare(Square):- member(Row,Square), nl, member(N,Row), write(N), write(' '), fail.
writeSquare(_).

