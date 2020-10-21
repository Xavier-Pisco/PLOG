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
    Soma1 is Soma - X,
    soma_lista(L, Soma1).