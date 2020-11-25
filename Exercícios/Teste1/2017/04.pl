:- [database].

listGamesOfCategory(Cat):-
	game(Game, Categories, Age),
	member(Cat, Categories),
	format('~s (~d)\n', [Game, Age]),
	fail.

listGamesOfCategory(_).