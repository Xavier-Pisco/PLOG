:- use_module(library(lists)).
:- use_module(library(clpfd)).

constroi(NEmb, Orcamento, EmbPorObjeto, CustoPorObjeto, EmbUsadas, Objetos):-
	length(Objetos, 4),
	length(EmbPorObjeto, N),
	domain(Objetos, 1, N),
	domain([EmbUsadas], 0, NEmb),
	all_distinct(Objetos),
	custoLimite(Orcamento, CustoPorObjeto, Objetos),
	embalagensLimite(EmbPorObjeto, Objetos, EmbUsadas),
	EmbUsadas #=< NEmb,
	labeling([], [EmbUsadas]),
	labeling([], Objetos).

custoLimite(Orcamento, _, []):- Orcamento >= 0.
custoLimite(Orcamento, CustoPorObjeto, [OH | OT]):-
	Orcamento >= 0,
	nth1(OH, CustoPorObjeto, Custo),
	Orcamento1 is Orcamento - Custo,
	custoLimite(Orcamento1, CustoPorObjeto, OT).

embalagensLimite(_, [], 0).
embalagensLimite(EmbPorObjeto, [OH | OT], EmbUsadas):-
	nth1(OH, EmbPorObjeto, Emb),
	embalagensLimite(EmbPorObjeto, OT, Temp),
	EmbUsadas is Temp + Emb.