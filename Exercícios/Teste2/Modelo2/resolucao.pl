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

	% Temp é um array de 0 e 1 para fazer produto escalar com os OvosPorReceita e os TempoPorReceita
	length(Temp, NumReceitas),
	domain(Temp, 0, 1),

	count(1, Temp, #=, 4), % Certifica que existem exatamente 4 1s em Temp
	scalar_product(TempoPorReceita, Temp, #=<, TempoMax), % Resultado do produto escalar é o tempo das 4 receitas
	scalar_product(OvosPorReceita, Temp, #=, OvosUsados), % Resultado do produto escalar é os ovos das 4 receitas
	OvosUsados #=< NOvos,

	labeling([maximize(OvosUsados)], Temp),
	findall(Index, nth1(Index, Temp, 1), Receitas). % Cria uma lista com os índices das posições com valor 1 em Temp


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