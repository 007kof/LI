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

