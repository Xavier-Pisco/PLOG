:- use_module(library(clpfd)).

table6(L):-
	L = [A,B,C,D,E,F],
	domain(L, 1, 6),
	all_distinct(L),
	A #= 1, % Removes soluções que são rotações
	A #= B + 1 #\/ A #= B - 1, % Ao não meter o lugar 1 ao lado do 6 ignora posições simétricas
	C #= D + 1 #\/ C #= D - 1,
	E #\= F + 1 #/\ E #\= F - 1,
	A #\= E + 1 #/\ A #\= E - 1,
	((E #= 6 #/\ F #\= 1) #\/ E #\= 6) #/\ ((F #= 6 #/\ E #\= 1) #\/ F #\= 6),
	((E #= 6 #/\ A #\= 1) #\/ E #\= 6) #/\ ((A #= 6 #/\ E #\= 1) #\/ A #\= 6),
	labeling([], L).

squareTable(L, N, Juntas, Separadas):-
	domain(L, 1, N),
	all_distinct(L),

	juntas(Juntas),
	separadas(Separadas),
	% Faltam restrições frente a frente

	labeling([], L).


juntas([]).
juntas([A-B | Juntas]):-
	A #= B + 1 #\/ A #= B - 1,
	juntas(Juntas).

separadas([]).
separadas([A-B | Separadas]):-
	A #\= B + 1 #/\ A #\= B - 1,
	separadas(Separadas).