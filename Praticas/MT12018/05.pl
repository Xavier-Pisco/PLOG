:- [database].

arrivalTime(Flight, ArrivalTime):-
	flight(Flight, _,_,DepartureTime,Time,_),
	Minutes is (DepartureTime mod 100 + Time mod 60) mod 60,
	Hours is (DepartureTime // 100 + Time // 60) + (DepartureTime mod 100 + Time mod 60) // 60,
	ArrivalTime is Hours * 100 + Minutes.

pairableFlights:-
	flight(Flight1, _, _, _, _, _),
	flight(Flight2, _, _, _, _, _),
	Flight1 \= Flight2,
	timeDifference(Flight1, Flight2, Airport, Time),
	Time =< 90,
	Time >= 30,
	format('~s - ~s \\ ~s', [Airport, Flight1, Flight2]), nl,
	fail.

timeDifference(Flight1, Flight2, Airport, Time):-
	flight(Flight1, _, Airport, _, _, _),
	flight(Flight2, Airport, _, Departure2, _, _),
	arrivalTime(Flight1, Arrival1),
	TimeHours is Departure2 // 100 - Arrival1 // 100,
	Time is Departure2 mod 100 - Arrival1 mod 100 + TimeHours * 60.