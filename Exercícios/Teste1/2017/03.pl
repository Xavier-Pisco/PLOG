:- [database].

timePlayingGames(_, [], [], 0).

timePlayingGames(Player, [GamesHead | GamesTail], [TimesHead | TimesTail], SumTimes):-
	timePlayed(Player, GamesHead, TimesHead),
	timePlayingGames(Player, GamesTail, TimesTail, TailSumTime),
	SumTimes is TimesHead + TailSumTime.

timePlayed(Player, Game, Time):-
	played(Player, Game, Time, _), !.

timePlayed(Player, Game, 0).