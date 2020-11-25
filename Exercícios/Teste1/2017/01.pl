:- [database].

achievedALot(Player):-
	played(Player, _, _, Completed),
	Completed >= 80.