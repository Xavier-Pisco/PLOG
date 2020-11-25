:- [database].

mostEffectivePlayer(Game, Players):-
	findall([Player, Ratio], (played(Player, Game, Time, Percentage), Ratio is Percentage / Time), Ratios),
	bestRatio(Ratios, 0, Ratio),
	removeLower(Ratios, Ratio, Players).

removeLower([], _, []).

removeLower([[Player, Ratio] | RatiosTail], Ratio, [Player | PlayersTail]):-
	removeLower(RatiosTail, Ratio, PlayersTail).

removeLower([[_, TempRatio] | Tail], Ratio, Players):-
	TempRatio < Ratio,
	removeLower(Tail, Ratio, Players).

bestRatio([], Best, Best).

bestRatio([[_, Ratio] | Tail], TempBest, Best):-
	TempBest >= Ratio,
	bestRatio(Tail, TempBest, Best).


bestRatio([[_, Ratio] | Tail], TempBest, Best):-
	TempBest < Ratio,
	bestRatio(Tail, Ratio, Best).
