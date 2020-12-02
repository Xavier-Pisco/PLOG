:- use_module(library(clpfd)).

magic(Vars):-
	Vars = [V1, V2, V3, V4, V5, V6, V7, V8, V9],
	domain(Vars, 1, 9),
	all_distinct(Vars),
	V1 + V2 + V3 #= S,
	V4 + V5 + V6 #= S,
	V7 + V8 + V9 #= S,
	V1 + V4 + V7 #= S,
	V2 + V5 + V8 #= S,
	V3 + V6 + V9 #= S,
	V1 + V5 + V9 #= S,
	V3 + V5 + V7 #= S,
	write(S),
	labeling([], Vars).

magic(N, Vars):-
	N2 is N * N,
	length(Vars, N2),
	domain(Vars, 1, N2),
	all_distinct(Vars),
	Soma is (1 + N2) / 2,
	constraintLines(Vars, N),
	constraintColumns(Vars, N),
	constraintDiagonals(Vars, N),
	labeling([], Vars).

removeN(L, 0, L).
removeN([_ | T], N, New):-
	N > 0,
	N1 is N - 1,
	removeN(T, N1, New).

constraintLines([], _).
constraintLines(Vars, N):-
	Vars \= [],
	N2 is N * N,
	Soma is integer((1 + N2) * N // 2),
	constraintLines(Vars, N, Soma),
	removeN(Vars, N, New),
	constraintLines(New, N).

constraintLines([H | _], 1, H).
constraintLines([H | T], N, Result):-
	N > 1,
	N1 is N - 1,
	constraintLines(T, N1, SubResult),
	H + SubResult #= Result.

constraintColumns(Vars, N):-
	Length is N * N - N,
	length(Vars, Length).
constraintColumns(Vars, N):-
	length(Vars, Length),
	Length > N * N - N,
	N2 is N * N,
	Soma is integer((1 + N2) * N // 2),
	constraintColumns(Vars, N, N, Soma),
	removeN(Vars, 1, New),
	constraintColumns(New, N).

constraintColumns([H | _], 1, _, H).
constraintColumns([H | T], N, Total, Result):-
	N > 1,
	Total1 is Total - 1,
	N1 is N - 1,
	removeN(T, Total1, NewTail),
	constraintColumns(NewTail, N1, Total, SubResult),
	H + SubResult #= Result.


constraintDiagonals(Vars, N):-
	N2 is N * N,
	Soma is integer((1 + N2) * N // 2),
	constraintDiagonalLeftToRight(Vars, N, N, Soma),
	removeN(Vars, N - 1, New),
	constraintDiagonalRightToLeft(New, N, N, Soma).

constraintDiagonalLeftToRight([H | _], 1, _, H).
constraintDiagonalLeftToRight([H|T], N, Total, Result):-
	N > 1,
	N1 is N - 1,
	removeN(T, Total, NewTail),
	constraintDiagonalLeftToRight(NewTail, N1, Total, SubResult),
	H + SubResult #= Result.

constraintDiagonalRightToLeft([H | T], 1, _, H).
constraintDiagonalRightToLeft([H|T], N, Total, Result):-
	N > 1,
	Total1 is Total - 2,
	N1 is N - 1,
	removeN(T, Total1, NewTail),
	constraintDiagonalRightToLeft(NewTail, N1, Total, SubResult),
	H + SubResult #= Result.

