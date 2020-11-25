:- [database].

avgFlightLengthFromAirport(Airport, AvgLength):-
	findall(Time, flight(_, Airport, _, _, Time, _), Lengths),
	sumLists(Lengths, TotalLength),
	length(Lengths, N),
	AvgLength is TotalLength / N.

sumLists([], 0).

sumLists([Head | Tail], Result):-
	sumLists(Tail, Temp),
	Result is Temp + Head.