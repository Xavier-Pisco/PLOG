# Teste 2 - Modelo 2

## Pergunta 1

Este predicado cria, em L2, uma lista com os elementos que fazem parte da lista L1 e ordena-os 3 a 3, ou seja, os três primeiros elementos estão ordenados, do 4º ao 6º também estão ordenados, etc. Esta ordenação pode ser tanto crescente como decrescente.

Quanto à eficácia, o programa é pouco eficiente pois constroí a lista inteira, depois verifica se está corretamente ordenada e, caso não esteja, volta à construção da lista para fazer de maneira diferente.

## [Pergunta 2](../Modelo/02.pl)
## [Pergunta 3](../Modelo/03.pl)

## Pergunta 4

Não está a otimizar pelo número de ovos usados, apenas está a escolher 4 receitas que funcionem

```
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
```
