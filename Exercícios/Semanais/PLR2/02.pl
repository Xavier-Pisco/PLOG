:- use_module(library(clpfd)).

treino(Instrumento, Dia):-
	Instrumento #= 2,
	Dia #= 1.

toca(J-IJ, A-IA, F-IF):-
	J = 'João',
	A = 'António',
	F = 'Francisco', !,
	Instrumentos = [IJ, IA, IF],
	Dias = [DJ, DA, DF],
	domain(Instrumentos, 0, 2),
	domain(Dias, 0, 1),
	all_distinct(Instrumentos),
	IA #\= 2,
	DJ #= 1,
	IJ #\= 1,
	(DA #= 0 #/\ DF #= 1 #/\ IA #= 2 #/\ IF #= 1) #\/ (DA #= 1 #/\ DF #= 0 #/\ IA #= 1 #/\ IF #= 2),
	labeling([], Dias),
	labeling([],Instrumentos).
