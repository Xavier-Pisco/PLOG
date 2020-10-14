/** Caso base, membro é a Head da lista */
membro(X,[X|_]).
/** Remover Head da lista e ver se membro faz parte da Tail */
membro(X,[_|L1]):-
    membro(X,L1).

/** 
Utilizar os _ nestas posições no append siginifica que antes e depois do elemento
X podemos ter qualquer lista.
*/
membro(X,L):-
    append(_,[X|_],L).

/** Neste caso podemos juntar qualquer lista com a lista [X] que a lista resultante vai ser
[..., X], logo, X vai ser o ultimo elemento da lista.
 */
last(L,X):-
    append(_,[X],L).

/** Caso base, se for o 1º membro é a Head */
nth_membro(1, [X|_], X).
/** Retira-se a Head da lista e subtrai-se 1 ao número do elemento */
nth_membro(N, [_|L], X):-
    N1 is N-1,
    nth_membro(N1, L, X).
