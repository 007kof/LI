letter(L):-member(L,[a,c,j,m,n,o,r,t,u]).

pert_con_resto(X,L,R) :- append(L1,[X|L2],L), append(L1,L2,R).

word( [c,a,r] ).
word( [r,u,n] ).
word( [n,o,t] ).
word( [j,a,m] ).
word( [j,u,t] ).
word( [j,a,r] ).
word( [j,o,t] ).
word( [m,o,c] ).

long([],0).
long([_|L],M) :- long(L,N), M is N+1.

dice(D, DP) :- permutation(D, DP), dice_correct_lentgh(D).

dice_correct_lentgh(D) :- long(D, L), L = 3.

dices(D1, D2, D3) :- dice(D1, DP1), dice(D2, DP2), dice(D3, DP3), write(DP1, DP2, DP3), nl, fail.
