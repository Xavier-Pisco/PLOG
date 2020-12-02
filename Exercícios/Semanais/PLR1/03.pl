:- use_module(library(clpfd)).

nqueens4x4(Cols):-
	Cols = [C1, C2, C3, C4], % Uma rainha por cada linha, apenas varia a coluna
	domain(Cols, 1, 4),
	all_distinct(Cols), % As colunas têm de ser todas diferentes
	% Cada rainha não pode ter outras rainhas nas diagonais (Apenas é preciso verificar para baixo)
	C1 #\= C2+1, C1 #\= C2-1, C1 #\= C3+2, C1 #\= C3-2, C1 #\= C4+3, C1 #\= C4-3,
	C2 #\= C3+1, C2 #\= C3-1, C2 #\= C4+2, C2 #\= C4-2,
	C3 #\= C4+1, C3 #\= C4-1,
	labeling([], Cols).

nqueens(N, Cols):-
	length(Cols, N),
	domain(Cols, 1, N),
	all_distinct(Cols),
	constraint(Cols),
	labeling([], Cols).

% Verify constraints for a list
constraint([]).
constraint([H | T]):-
	notDiagonal(H, T, 1),
	constraint(T).

% Verifies if every elemente on Tail by order is not on diagonal
notDiagonal(_, [], _).
notDiagonal(C1, [CN | T], N):-
	C1 #\= CN + N,
	C1 #\= CN - N,
	N1 is N + 1,
	notDiagonal(C1, T, N1).