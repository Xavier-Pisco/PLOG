substitui(_, _, [], []).

substitui(X, Y, [X|L1], [Y|L2]):-
    substitui(X, Y, L1, L2).

substitui(X, Y, [A|L1], [A|L2]):-
    X \= A,
    substitui(X, Y, L1, L2).

elimina(_, [], []).

elimina(X, [X|L1], L2):-
    elimina(X, L1, L2).

elimina(X, [Y|L1], [Y|L2]):-
    X \= Y,
    elimina(X, L1, L2).

elimina_duplicados([],[]).

elimina_duplicados([X|L1], [X|L2]):-
    elimina(X, L1, L3),
    elimina_duplicados(L3, L2).