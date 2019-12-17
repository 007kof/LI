perm([], []).
perm([X | L], P) :- perm(L, P1), append(Pa, Pb, P1), append(Pa, [X | Pb], P).
