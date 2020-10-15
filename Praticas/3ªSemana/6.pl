delete_one(X, L1, L2):-
    % Cria duas listas (L3 e L4) que, juntando no meio X, formam a lista original
    append(L3, [X|L4], L1),
    % Juntando essas duas listas obtemos uma lista sem o elemento X
    append(L3, L4, L2).

% Caso base
delete_all(X, [], []).

% Se Head for o elemento a eliminar, remove-o e não altera L2 
delete_all(X, [X|L1], L2):-
    delete_all(X, L1, L2).

% Se Head for diferente do elemento a eliminar altera a Head de L2 para ser igual à Head de L1
delete_all(X, [Y|L1], [Y|L2]):-
    X \= Y,
    delete_all(X, L1, L2).