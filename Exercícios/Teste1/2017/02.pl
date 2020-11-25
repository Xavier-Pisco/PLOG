:- [database].

isAgeAppropriate(Name, Game):-
	player(Name, _, Age),
	game(Game, _, MinimumAge),
	Age >= MinimumAge.