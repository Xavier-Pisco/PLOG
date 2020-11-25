:- [database].

updatePlayer(Player, Game, Hours, Percentage):-
	retract(played(Player, Game, PreviousHours, PreviousPercentage)),
	FinalHours is PreviousHours + Hours,
	FinalPercentage is PreviousPercentage + Percentage,
	assert(played(Player, Game, FinalHours, FinalPercentage)).