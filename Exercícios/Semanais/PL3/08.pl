conta([], 0).

conta([_|L], N):-
    N > 0,
    N1 is N - 1,
    conta(L, N1).


conta_elem(_, [], 0).

conta_elem(X, [X|L], N):-
    N > 0,
    N1 is N - 1,
    conta_elem(X, L, N1).

conta_elem(X, [Y|L], N):-
    X \= Y,
    conta_elem(X, L, N).