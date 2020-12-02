:- use_module(library(clpfd)).

custo(M, U):-
	domain([M, U], 0, 9),
	M #> 0,
	(M * 1000 + 670 + U) mod 72 #= 0,
	labeling([], [M, U]).
