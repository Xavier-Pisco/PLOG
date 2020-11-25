:- [database].

fewHours(Player, Games):-
	fewHoursAux(Player, [], Games).

fewHoursAux(Player, Aux, Games):-
	played(Player, Game, Time, _),
	Time < 10,
	\+member(Game, Aux), !,
	fewHoursAux(Player, [Game | Aux], Games).

fewHoursAux(_, Games, Games).
