:- [database].

niceGuy(User):-
	vote(User, Votes),
	member(Movie1-Vote1, Votes),
	member(Movie2-Vote2, Votes),
	Movie1 \= Movie2,
	Vote1 >= 8,
	Vote2 >= 8.
