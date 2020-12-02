:- use_module(library(clpfd)).

preco(A1, B1, E1, L1):-
	domain([A, B, E, L], 1, 700),
	all_distinct([A,B,E,L]),
	A + B + E + L #= 711,
	B #> L, L #> A, A #> E,
	tens([A,B,E,L], 2),
	labeling([], [A, B, E, L]),
	A1 is A / 100,
	B1 is B / 100,
	E1 is E / 100,
	L1 is L / 100,
	A1 * B1 * E1 * L1 =:= A1 + B1 + E1 + L1.

tens([], 0).

tens([H | T], N):-
	H mod 10 #= 0,
	tens(T, SubN),
	N is SubN + 1.

tens([H | T], N):-
	H mod 10 #\= 0,
	tens(T, N).