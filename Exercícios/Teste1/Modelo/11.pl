impoe(X,L) :-
    length(Mid,X),
    append(L1,[X|_],L), append(_,[X|Mid],L1).

%langford(+N,-L)
langford(N,L):-
	N > 0,
	N2 is 2 * N,
	length(L, N2),
	impoeTodos(N, L).

impoeTodos(0, _).
impoeTodos(N, L):-
	impoe(N, L),
	N1 is N - 1,
	impoeTodos(N1, L).