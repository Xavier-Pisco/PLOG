lista_ate(N, L):-
    N > 0,
    lista_ate(N, L, 0).

lista_ate(0, [], _).

lista_ate(N, [X|L], Y):-
    N > 0,
    Y1 is Y + 1,
    X is Y1,
    N1 is N - 1,
    lista_ate(N1, L, Y1).

lista_entre(N, N, [N]).

lista_entre(N1, N2, [N1|L]):-
    N1 =< N2,
    X1 is N1 + 1,
    lista_entre(X1, N2, L).

soma_lista([], 0).

soma_lista([X|L], Soma):-
    soma_lista(L, SomaTail),
    Soma is SomaTail + X.

par(X):-
    X > 0,
    0 is mod(X, 2).

lista_pares(1, []).
lista_pares(0, []).

lista_pares(N, [N | L]):-
    par(N),
    N1 is N - 2,
    lista_pares(N1, L).

lista_pares(N, [X | L]):-
    X is N - 1,
    par(X),
    N1 is N - 3,
    lista_pares(N1, L).

lista_impares(1, [1]).
lista_impares(0, []).

lista_impares(N, [N | L]):-
    N > 1,
    \+par(N),
    N1 is N - 2,
    lista_impares(N1, L).

lista_impares(N, [X | L]):-
    N > 1,
    X is N - 1,
    \+par(X),
    N1 is N - 3,
    lista_impares(N1, L).