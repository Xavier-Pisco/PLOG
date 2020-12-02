delete_one(X, L1, L2):-
    % Cria duas listas (L3 e L4) que, juntando no meio X, formam a lista original
    append(L3, [X|L4], L1),
    % Juntando essas duas listas obtemos uma lista sem o elemento X
    append(L3, L4, L2).

permutacao([],[]).

permutacao([X|L1], L2):-
    member(X, L2),
    delete_one(X, L2, L3),
    permutacao(L1, L3).