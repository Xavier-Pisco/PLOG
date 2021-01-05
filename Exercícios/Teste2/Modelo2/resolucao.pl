:- use_module(library(lists)).
:- use_module(library(clpfd)).

p1(L1,L2) :-
    gen(L1,L2),
    test(L2).

% gen(L1, L2) - Cria uma lista L2 com os elementos de L1 em posição 'aleatória'
gen([],[]).
gen(L1,[X|L2]) :-
    select(X,L1,L3),	% Copia a L1 para L3 exceto o valor X
    gen(L3,L2).

test([]).
test([_]).
test([_,_]).
test([X1,X2,X3|Xs]) :-
    (X1 < X2, X2 < X3; X1 > X2, X2 > X3),	% Verifica se os 3 primeiros elementos da lista estão ordenados
    test(Xs).

receitas(NOvos, TempoMax, OvosPorReceita, TempoPorReceita, OvosUsados, Receitas):-
	length(OvosPorReceita, NumReceitas),
	length(Receitas, 4),
	domain(Receitas, 1, NumReceitas),
	all_distinct(Receitas),
	tempo(TempoPorReceita, Receitas, 1, TempoUsado),
	TempoUsado =< TempoMax,
	ovos(OvosPorReceita, Receitas, 1, OvosUsados),
	OvosUsados =< NOvos,
	labeling([maximize(OvosUsados)], Receitas).

tempo(_, [], _, 0).
tempo([TH | TT], [RH | RT], Current, TempoUsado):-
	RH #= Current,
	Next is Current + 1,
	tempo(TT, RT, Next, TempoMid),
	TempoUsado is TempoMid + TH.
tempo([_ | TT], Receitas, Current, TempoUsado):-
	Next is Current + 1,
	tempo(TT, Receitas, Next, TempoUsado).

ovos(_, [], _, 0).
ovos([OH | OT], [RH | RT], Current, OvosUsados):-
	RH #= Current,
	Next is Current + 1,
	tempo(OT, RT, Next, OvosMid),
	OvosUsados is OvosMid + OH.
ovos([_ | OT], Receitas, Current, OvosUsados):-
	Next is Current + 1,
	tempo(OT, Receitas, Next, OvosUsados).