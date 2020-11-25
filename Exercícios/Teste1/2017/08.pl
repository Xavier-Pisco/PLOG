:- [database].

averageAge(Game, Average):-
	findall(Age, (played(Player, Game, _, _), player(_, Player, Age)), Ages),
	length(Ages, N),
	sumList(Ages, Sum),
	Average is Sum / N.

sumList([], 0).

sumList([Head | Tail], Total):-
	sumList(Tail, SubTotal),
	Total is SubTotal + Head.