:- use_module(library(clpfd)).

restricoes(CR, CS, S):-
	CS #= CR,
	S #= 2.

comboio(M):-
	Cidades = [CR, CF, CM, CSF, CSR, CSS],
	Salarios = [SR, SF, SM, SSF, SSR, SSS],
	Nomes = [R, F, M],
	domain(Cidades, 0, 2),
	domain(Salarios, 0, 2),
	domain(Nomes, 0, 2),
	all_distinct(Nomes),
	CSR #= 0,
	CR #= 1,
	SF #= 0,
	restricoes(CR, CSF, SSF),
	labeling([], Cidades),
	labeling([], Salarios),
	labeling([], Nomes),
	write(Cidades),
	write(Salarios),
	write(Nomes).
