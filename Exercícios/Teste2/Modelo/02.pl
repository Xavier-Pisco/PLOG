:- consult('01.pl').
:- use_module(library(clpfd)).

p2(L1,L2) :-
    length(L1,N),
    length(L2,N),
    % Aqui devia ser definido o domínio das variáveis
    pos(L1,L2,Is),
    all_distinct(Is),
    % Faltam restrições pois a lista pode chegar aqui em qualquer ordem
    labeling([],Is),
    test(L2).

pos([],_,[]).
pos([X|Xs],L2,[I|Is]) :-
    nth1(I,L2,X),
    pos(Xs,L2,Is).

/*
As variáveis de domínio estão a ser instanciadas antes da fase de pesquise e nem todas as restrições foram colocadas antes da fase de pesquisa
*/