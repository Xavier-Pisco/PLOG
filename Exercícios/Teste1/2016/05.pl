:- [database].

printCategory(Category):-
	film(Title, Categories, Duration, AvgClassification),
	member(Category, Categories),
	format('~s (~dmin, ', [Title, Duration]),
	write(AvgClassification),
	write('/10)\n'),
	fail.

printCategory(_).
