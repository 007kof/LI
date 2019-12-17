
path(_,N,N):- !. %quan N1 = N2 acabem ja que hem trobat un camí

path(G,N1,N2):- select([N1,N3],G,R), path(R,N3,N2),!.

%et donen una llista de llistes, on cada subllista representa una adjacencia entre v i u, et demanen si hi ha un cami entre u i v

negate(\+X,X):-!.

negate(X,\+X).

sat(N,S):-

   findall(       ,     , G1 ),

   findall(       ,     , G2 ),  append(G1,G2,G),

   \+badCycle(N,G).

   

badCycle(N,G):- .....
