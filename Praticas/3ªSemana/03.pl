/** 
Caso base 
Na solução da ficha o caso base é, se removermos a primeira lista da lista final ficamos com a segunda lista
*/
myAppend([],[],[]).

/** Se a primeira lista for vazia passamos para a segunda */
myAppend([],[X|L2],[X|L3]):-
    myAppend([],L2,L3).

/** 
O primeiro elemento da primeira lista tem de ser igual ao primeiro elemento da lista resultante,
ou seja, se removermos o mesmo elemento da Head de L1 e L3 o append tem de continuar a ser verdadeiro.
 */
myAppend([X|L1],L2,[X|L3]):- 
    myAppend(L1, L2, L3).