:- [database].

similarity(Film1, Film2, Similarity):-
	film(Film1, Categories1, Duration1, AvgClassification1),
	film(Film2, Categories2, Duration2, AvgClassification2),
	differentCats(Categories1, Categories2, TotalCats, DifferentCats),
	Similarity is float(DifferentCats / TotalCats * 100 - 3 * abs(Duration1 - Duration2) - 5*abs(AvgClassification1 - AvgClassification2) ).

differentCats([], _, 0, 0).

differentCats([Head|Cat1], Cat2, TotalCats, DifferentCats):-
	member(Head, Cat2),
	differentCats(Cat1, Cat2, SubTotal, DifferentCats),
	TotalCats is SubTotal + 1.

differentCats([Head | Cat1], Cat2, TotalCats, DifferentCats):-
	\+member(Head, Cat2),
	differentCats(Cat1, Cat2, TotalCats, SubDifferent),
	DifferentCats is SubDifferent + 1.
