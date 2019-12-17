padre(juan, pedro).
padre(maria, pedro).

hermano(pedro, enrique).
hermano(pedro, carlos).

tio(S, T) :- padre(S, P), hermano(P, T).
