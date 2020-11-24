:- [database].

arrivalTime(Flight, ArrivalTime):-
	flight(Flight, _,_,DepartureTime,Time,_),
	Minutes is (DepartureTime mod 100 + Time mod 60) mod 60,
	Hours is (DepartureTime // 100 + Time // 60) + (DepartureTime mod 100 + Time mod 60) // 60,
	ArrivalTime is Hours * 100 + Minutes.