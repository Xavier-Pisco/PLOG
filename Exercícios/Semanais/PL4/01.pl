reverse1([],L,L).

reverse1([X|L1],Temp,L2):-
    reverse1(L1, [X|Temp], L2).
    
reverse(L1, L2):-
    reverse1(L1, [], L2).

ligado(a,b). 
ligado(f,i).
ligado(a,c). 
ligado(f,j).
ligado(b,d). 
ligado(f,k).
ligado(b,e). 
ligado(g,l).
ligado(b,f). 
ligado(g,m).
ligado(c,g). 
ligado(k,n).
ligado(d,h). 
ligado(l,o).
ligado(d,i). 
ligado(i,f). 

resolva_prof(No, No_meta, Sol):-
    profundidade([], No, No_meta, Sol_inv),
    reverse(Sol_inv, Sol).

profundidade(Caminho, No_meta, No_meta, [No_meta|Caminho]).

profundidade(Caminho, No, No_meta, Sol):-
    ligado(No, Filho),  
    \+member(Filho, Caminho),
    profundidade([No|Caminho], Filho, No_meta, Sol).
