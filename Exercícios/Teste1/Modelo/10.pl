impoe(X,L) :-
    length(Mid,X),
    append(L1,[X|_],L), append(_,[X|Mid],L1).

/**
Esta função cria uma lista que começa e acaba com o valor X e tem
X elementos não definidos no meio da lista.

Por exemplo: [3, X, Y, Z, 3].
*/