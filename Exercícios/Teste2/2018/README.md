# Teste 2 - 2017/18

[teste](https://drive.google.com/drive/folders/1BKs1-kU6aiDKfdBx5iX1q8P8qdviIu4M)

## Pergunta 1

Este programa recebe dois inteiros, N e M, e produz duas listas, L1 e L2, de tamanhos N e N-1 respetivamente.
A primeira chamada ao predicado fill preenche a lista L1 com N números diferentes entre 1 e M, enquanto que a segunda chamada a esse mesmo predicado preenche a lista L2 com números entre 1 e M que não existem na lista L1. Assim, M é, obrigatoriamente, maior ou igual a 2N - 1.
Por fim, o predicado check verifica se os números da lista L2 são a soma dos números de L1 2 a 2. Esta verificação é feita por ordem, ou seja, o 1º número de L2 corresponde à soma dos 2 primeiros números de L1, o 2º número à soma dos 2º e 3º números de L1, etc.

## Pergunta 2

As duas listas juntas vão ter 2N - 1 elementos diferentes.

Existem M variáveis diferentes.

Espaço de procura: M<sup>2N-1</sup>

## Pergunta 3

```
prog2(N, M, L1, L2):-
	length(L1, N),
	N1 is N - 1, length(L2, N1),
	domain(L1, 1, M),
	domain(L2, 1, M),
	append(L1, L2, L3),
	all_distinct(L3),
	check2(L1, L2),
	labeling([], L1).

check2([_], []).
check2([A, B | R], [X | Xs]):-
	A + B #= X,
	check2([B | R], Xs).
```

## Pergunta 4

```
gym_pairs(ManHeights, WomenHeights, Delta, Pairs):-
	length(ManHeights, Men),
	length(WomenHeights, Women),
	Men =:= Women,
	length(Pairs, Men),
	length(Pair, Men), % List of all mans and cotains the indice of the woman
	domain(Pair, 1, Men),
	all_distinct(Pair),
	setHeights(ManHeights, WomenHeights, Delta, Pair, 1),
	labeling([], Pair),
	prepare(Pair, Pairs, 1). % Just change output from a single list to a list with pairs

setHeights(_, _, _, [], _).
setHeights(ManHeights, WomenHeights, Delta, [PH | PT], Current):-
	nth1(Current, ManHeights, ManHeigth),
	nth1(X, WomenHeights, WomenHeight), % Tries any womenHeight for the curren manHeight
	0 =< ManHeigth - WomenHeight,
	Delta >= ManHeigth - WomenHeight,
	PH #= X,	% If heights are compatible then the pair number is the number of the women
	Next is Current + 1,
	setHeights(ManHeights, WomenHeights, Delta, PT, Next).

prepare([],[],_).
prepare([PH | PT], [PSH | PST], Current):-
	PSH = Current-PH,
	Next is Current + 1,
	prepare(PT, PST, Next).
```

## Pergunta 5

Não funciona para todos os casos mas acerta alguns.

```
optimal_skating_pairs(ManHeights, WomenHeights, Delta, Pairs):-
	length(ManHeights, Men),
	length(WomenHeights, Women),
	length(Pair, Men),
	domain(Pair, 0, Women),
	all_distinct_except_0(Pair),
	setHeights(ManHeights, WomenHeights, Delta, Pair, 1),
	countNonZeros(Pair, Number),
	labeling([maximize(Number)], Pair),
	prepare2(Pair, Pairs, 1). % Just change output from a single list to a list with pairs

countNonZeros([], 0).
countNonZeros([PH | PT], Number):-
	countZeros(PT, Temp),
	(PH is 0, Number is Temp; Number is Temp + 1).

prepare2([],[],_).
prepare2([0 | PT], Pairs, Current):-
	Next is Current + 1,
	prepare2(PT, Pairs, Next).
prepare2([PH | PT], [PSH | PST], Current):-
	PH \= 0,
	PSH = Current-PH,
	Next is Current + 1,
	prepare2(PT, PST, Next).
```
