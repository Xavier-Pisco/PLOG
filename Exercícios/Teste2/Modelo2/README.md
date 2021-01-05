# Teste 2 - Modelo 2

## Pergunta 1

Este predicado cria, em L2, uma lista com os elementos que fazem parte da lista L1 e ordena-os 3 a 3, ou seja, os três primeiros elementos estão ordenados, do 4º ao 6º também estão ordenados, etc. Esta ordenação pode ser tanto crescente como decrescente.

Quanto à eficácia, o programa é pouco eficiente pois constroí a lista inteira, depois verifica se está corretamente ordenada e, caso não esteja, volta à construção da lista para fazer de maneira diferente.

## [Pergunta 2](../Modelo/02.pl)
## [Pergunta 3](../Modelo/03.pl)

## Pergunta 4

Não está a otimizar pelo número de ovos usados, apenas está a escolher 4 receitas que funcionem

```prolog
receitas(NOvos, TempoMax, OvosPorReceita, TempoPorReceita, OvosUsados, Receitas):-
	length(OvosPorReceita, NumReceitas),

	% Temp é um array de 0 e 1 para fazer produto escalar com os OvosPorReceita e os TempoPorReceita
	length(Temp, NumReceitas),
	domain(Temp, 0, 1),

	count(1, Temp, #=, 4), % Certifica que existem exatamente 4 1s em Temp
	scalar_product(TempoPorReceita, Temp, #=<, TempoMax), % Resultado do produto escalar é o tempo das 4 receitas
	scalar_product(OvosPorReceita, Temp, #=, OvosUsados), % Resultado do produto escalar é os ovos das 4 receitas
	OvosUsados #=< NOvos,

	labeling([maximize(OvosUsados)], Temp),
	findall(Index, nth1(Index, Temp, 1), Receitas). % Cria uma lista com os índices das posições com valor 1 em Temp
```

## Pergunta 4 - 2

```prolog
build(Budget, NPacks, ObjectCosts, ObjectPacks, Objects, UsedPacks):-
	length(ObjectCosts, N),

	length(Temp, N),
	domain(Temp, 0, 1),

	count(1, Temp, #=, 3),
	scalar_product(ObjectCosts, Temp, #=, Budget),
	scalar_product(ObjectPacks, Temp, #=, UsedPacks),
	UsedPacks #=< NPacks,

	labeling([maximize(UsedPacks)], Temp),
	findall(Index, nth1(Index, Temp, 1), Objects).
```


## [Pergunta 5](../Modelo/05.pl)