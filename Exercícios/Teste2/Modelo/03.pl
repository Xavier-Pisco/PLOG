:- consult('02.pl').
:- use_module(library(clpfd)).

p3(L1,L2) :-
    length(L1,N), % [1,2,5,3]
    length(L2,N), % [1,2,3,5]
    length(Is, N), % [1,2,4,3]
	domain(Is, 1, N),
    pos(L1,L2,Is),
    all_distinct(Is),
	test2(L2),
    labeling([],Is). % 1 - 4 1243

pos([],_,[]).
pos([X|Xs],L2,[I|Is]) :-
    nth1(I,L2,X),
    pos(Xs,L2,Is).

test2([_,_]).
test2([X1,X2,X3|Xs]) :-
    (X1 #< X2, X2 #< X3; X1 #> X2, X2 #> X3),
    test2([X2,X3|Xs]).