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


stat(ana, thresh, 1000, 200).
stat(ana, evelyn, 150, 200).
stat(joao, ezreal, 300, 40).
stat(joao, wukong, 100, 40).
stat(carlos, nidalee, 56, 60).
stat(carlos, thresh, 70, 6).
pref(ana, thresh).
pref(joao, wukong).
pref(carlos, nidalee).
charsMap([1-thresh, 2-evelyn, 3-ezreal, 4-wukong, 5-nidalee]).

rightChoice(J):-
	findall(Ratio-Champ, (stat(J, Champ, Wins, Loses), Ratio is Wins / Loses), Ratios),
	pref(J, Champ),
	max_member(_-BestChamp, Ratios),
	BestChamp = Champ.

ratio(Player, Champ, Ratio):-
	stat(Player, Champ, Wins, Loses),
	Ratio #= 100 * Wins / Loses.

team(Players, T):-
	charsMap(Chars),
	findall(Champ, nth1(_, Chars, _-Champ), Champs),
	length(Players, N2),
	length(Team, N2),
	length(Chars, N1),
	domain(Team, 1, N1),
	preferences(Players, Champs, Team),
	ratios_sum(Players, Champs, Team, Ratio),
	labeling([maximize(Ratio)], Team),
	findall(Champ, (nth1(_, Team, Number), nth1(Number, Champs, Champ)), T).

preferences([], _, []).
preferences([P | Players], Champs, [T | Team]):-
	rightChoice(P),
	pref(P, C),
	element(Index, Champs, C),
	T #= Index,
	preferences(Players, Champs, Team).
preferences([_ | Players], Champs, [_ | Team]):-
	preferences(Players, Champs, Team).

ratios_sum([], _, [], 0).
ratios_sum([P | Players], Champs, [T | Team], Total):-
	ratios_sum(Players, Team, SubTotal),
	element(T, Champs, Champ),
	ratio(P, Champ, Ratio),
	Total #= SubTotal + Ratio.
