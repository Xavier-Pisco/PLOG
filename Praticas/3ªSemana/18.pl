duplicar([], []).

duplicar([X|L], [X|[X|L1]]):-
  duplicar(L, L1).

/**
duplicarN não funciona
*/
duplicarN([], _, []).
duplicarN([X|_], 1, [X|_]).
duplicarN([X|L], N, [X|L1]):-
  N1 is N - 1,
  duplicarN([X|L], N1, L1).