:- [database].

elemsComuns([], [], L).

elemsComuns([Head | Tail], [Head | Common], List2):-
	member(Head, List2), !,
	elemsComuns(Tail, Common, List2).

elemsComuns([Head | Tail], Common, List2):-
	elemsComuns(Tail, Common, List2).