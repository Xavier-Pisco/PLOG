:- [database].

short(Flight):-
	flight(Flight, _,_,_,Time,_),
	Time < 90.
