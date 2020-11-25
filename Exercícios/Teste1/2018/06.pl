:- [database].

arrivalTime(Flight, ArrivalTime):-
	flight(Flight, _,_,DepartureTime,Time,_),
	Minutes is (DepartureTime mod 100 + Time mod 60) mod 60,
	Hours is (DepartureTime // 100 + Time // 60) + (DepartureTime mod 100 + Time mod 60) // 60,
	ArrivalTime is Hours * 100 + Minutes.

tripDays([Destination], _, [], 1):-
	airport(_, _, Destination).

tripDays([TripHead, Destination | TripTail], Time, [FlightTimesHead | FlightTimesTail], Days):-
	airport(_, Airport, TripHead),
	airport(_, Airport2, Destination),
	flight(Flight, Airport, Airport2, FlightTimesHead, Duration, _),
	arrivalTime(Flight, ArrivalTime),
	(FlightTimesHead > Time ->
		trip([Destination | TripTail], ArrivalTime, FlightTimesTail, Days);
		trip([Destination | TripTail], ArrivalTime, FlightTimesTail, TempDays),
		Days is TempDays + 1
	).