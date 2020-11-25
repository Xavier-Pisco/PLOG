:- [database].

shorter(Flight1, Flight2, Flight1):-
	flight(Flight1, _,_,_,Time1,_),
	flight(Flight2, _,_,_,Time2,_),
	Time1 < Time2.

shorter(Flight1, Flight2, Flight2):-
	flight(Flight1, _,_,_,Time1,_),
	flight(Flight2, _,_,_,Time2,_),
	Time2 < Time1.
