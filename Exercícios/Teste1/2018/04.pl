:- [database].

countries(Company, Countries):-
	countriesAux(Company, [], Countries).


countriesAux(Company, Temp, Countries):-
	operates(Company, Country),
	\+member(Country, Temp), !,
	countriesAux(Company, [Country | Temp], Countries).

countriesAux(_, Countries, Countries).

operates(Company, Country):-
	flight(_, Airport, _, _, _, Company),
	airport(_, Airport, Country).

