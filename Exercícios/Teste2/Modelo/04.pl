:- use_module(library(lists)).
:- use_module(library(clpfd)).

constroi(NEmb, Orcamento, EmbPorObjeto, CustoPorObjeto, EmbUsadas, Objetos):-
	findall(Emb-Obj, temp(NEmb, Orcamento, EmbPorObjeto, CustoPorObjeto, Emb, Obj), Results), !,
	findMax(Results, EmbUsadas, Objetos).

temp(NEmb, Orcamento, EmbPorObjeto, CustoPorObjeto, EmbUsadas, Objetos):-
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

findMax([], 0, []).
findMax([Emb-Obj | Tail], MaxEmb, MaxObj):-
	findMax(Tail, TempMax, TempObj),
	(TempMax > Emb,
		MaxEmb is TempMax,
		MaxObj = TempObj;
		MaxEmb is Emb,
		MaxObj = Obj
	).

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