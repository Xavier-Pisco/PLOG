:- [database].

ageRange(MinAge, MaxAge, Players):-
	findall(Name, (player(Name, _, Age), Age =< MaxAge, Age >= MinAge), Players).