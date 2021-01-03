:- use_module(library(lists)).

p1(L1,L2) :-
    gen(L1,L2),
    test(L2).

% gen(L1, L2) - Cria uma lista L2 com os elementos de L1 em posição 'aleatória'
gen([],[]).
gen(L1,[X|L2]) :-
    select(X,L1,L3),	% Copia a L1 para L3 exceto o valor X
    gen(L3,L2).

% Verifica se uma Lista está ordenada (crescente ou decrescente)
test([_,_]).
test([X1,X2,X3|Xs]) :-
    (X1 < X2, X2 < X3; X1 > X2, X2 > X3),	% Verifica se os 3 primeiros elementos da lista estão ordenados
    test([X2,X3|Xs]).


/*
O predicado gen cria uma lista L2 com todos os elementos de L1, fazendo variar a ordem dos mesmos
O predicado test verifica se uma determinada lista se encontra ordenada, verificando se os 3 primeiros elementos estão ordenadas até haver apenas 2 elementos
Assim, o predicado p1 ordena a lista L1 e atribui o resultado a L2
Quanto à eficácia do programa, é um programa pouco eficiente, uma vez que o programa percorre uma vez a lista para a criar e
percorre outra vez para verificar se a mesma está ordenada, fazendo com que seja necessário percorrer várias vezes a lista para a ordenar.


*/