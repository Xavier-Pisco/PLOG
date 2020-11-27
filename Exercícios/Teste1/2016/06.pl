:- [database].

similarity(Film1, Film2, Similarity):-
	film(Film1, Categories1, Duration1, AvgClassification1),
	film(Film2, Categories2, Duration2, AvgClassification2),
	differentCats(Categories1, Categories2, SimilarCats, DifferentCats),
	write([SimilarCats, DifferentCats]), nl,
	Similarity is float(SimilarCats / DifferentCats * 100 - 3 * abs(Duration1 - Duration2) - 5*abs(AvgClassification1 - AvgClassification2) ).

differentCats([], _, 0, 0).

differentCats(Cat1, Cat2, SimilarCats, DifferentCats):-
	elemsComuns(Cat1, CommonCats, Cat2),
	length(Cat1, Len1),
	length(Cat2, Len2),
	length(CommonCats, SimilarCats),
	DifferentCats is ((Len1 - SimilarCats) + (Len2 - SimilarCats)).


elemsComuns([], [], L).

elemsComuns([Head | Tail], [Head | Common], List2):-
	member(Head, List2), !,
	elemsComuns(Tail, Common, List2).

elemsComuns([Head | Tail], Common, List2):-
	elemsComuns(Tail, Common, List2).
