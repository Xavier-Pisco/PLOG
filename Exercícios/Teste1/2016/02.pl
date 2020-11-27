:- [database].

diff(User1, User2, Difference, Film):-
	vote(User1, Votes1),
	vote(User2, Votes2),
	member(Film-Rating1, Votes1),
	member(Film-Rating2, Votes2),
	Difference is abs(Rating1 - Rating2).

difference(Rating1, Rating2, Difference):-
	Rating1 >= Rating2,
	Difference is Rating1 - Rating2.

difference(Rating1, Rating2, Difference):-
	Rating2 > Rating1,
	Difference is Rating2 - Rating1.