:- use_module(library(clpfd)).


soma_e_multiplicacao(A, B, C):-
	domain([A, B, C], -10, 10),
	A #\= 0, B#\= 0, C#\=0,
	A * B * C #= A + B + C,
	A #>= B, B#>= C,
	labeling([], [A,B,C]).