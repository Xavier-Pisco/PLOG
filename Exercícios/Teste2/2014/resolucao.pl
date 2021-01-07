:- use_module(library(clpfd)).
:-use_module(library(lists)).

sequence(L):-
	length(L, 6),
	domain(L, 1, 7),
	all_distinct(L),
	consecutive(L),
	simetric(L),
	labeling([], L).

simetric([X | L]):-
	last(L, Y),
	X #< Y.

consecutive([_]).
consecutive([X, Y | L]):-
	X mod 2 #\= Y mod 2 #/\ X + 1 #\= Y #/\ X - 1 #\= Y,
	consecutive([Y | L]).

sequence(N, L):-
	length(L, N),
	N1 is N + 1,
	domain(L, 1, N1),
	all_distinct(L),
	consecutive(L),
	first_and_last(L),
	labeling([], L).

first_and_last([X | L]):-
	last(L, Y),
	X #< Y #/\
	X mod 2 #\= Y mod 2 #/\ X + 1 #\= Y #/\ X - 1 #\= Y.