/** Caso base (lista invertida igual ao resultado) */
rev([],L,L).

/**
Se removermos a Head de uma lista e a metermos como Head de outra até a primeira ficar vazia
a segunda lista vai ficar com a lsita invertida da mesma
*/
rev([X|L1],Temp,L2):-
    rev(L1, [X|Temp], L2).

inverter(L1, L2):-
    rev(L1, [], L2).

/*
palindroma(L):-
  inverter(L, L).
*/

palindroma([],L, L).
palindroma([H | L], L1, L2):-
  palindroma(L, [H | L1], L2).

palindroma(L):-
  palindroma(L, [], L1),
  L == L1.
