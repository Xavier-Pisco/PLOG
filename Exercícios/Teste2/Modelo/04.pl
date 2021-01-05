:- use_module(library(lists)).
:- use_module(library(clpfd)).


constroi(NEmb, Orcamento, EmbPorObjeto, CustoPorObjeto, EmbUsadas, Objetos):-
	length(EmbPorObjeto, N),

	length(Temp, N),
	domain(Temp, 0, 1),

	count(1, Temp, #=, 4),
	scalar_product(CustoPorObjeto, Temp, #=<, Orcamento),
	scalar_product(EmbPorObjeto, Temp, #=, EmbUsadas),
	EmbUsadas #=< NEmb,

	labeling([maximize(EmbUsadas)], Temp),
	findall(Index, nth1(Index, Temp, 1), Objetos).