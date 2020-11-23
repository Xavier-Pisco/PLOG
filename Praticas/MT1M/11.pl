impoe(X,L) :-
    length(Mid,X),
    append(L1,[X|_],L), append(_,[X|Mid],L1).

%langford(+N,-L)
langford(N,L):-
	N > 0,
	N2 is 2 * N,
	length(L, N2),
	impoe(N, L),
	removeHead(L, L1),
	removeLast(L1, L2),
	N1 is N - 1,
	langford(N1, L2).

removeHead([Head | Tail], Tail).
removeLast([Head | Tail], [Head | []]):-
	length(Tail, 1).

removeLast([Head | Tail], [Head | NewTail]):-
	\+length(Tail, 0),
	removeLast(Tail, NewTail).