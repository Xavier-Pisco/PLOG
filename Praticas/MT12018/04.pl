:- [database].

countries(Company, Countries):-
	findall(Company, flight(_, _, _, _, _, Company), Companies).
	operates(Company, Country),
	countries(Company, CountriesTail).

operates(Company, Country):-
	flight(_, Airport, _, _, _, Company),
	airport(_, Airport, Country).

