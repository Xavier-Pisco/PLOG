:- [database].

operates(Company, Country):-
	flight(_, Airport, _, _, _, Company),
	airport(_, Airport, Country).

mostInternational(ListOfCompanies):-
	findall(Company, company(Company, _, _, _), Companies),
	international(Companies, ListOfCompanies).

international([], []).

international([Company | CompaniesTail], [Company | ListOfCompaniesTail]):-
	airport(_, _, Country1),
	airport(_, _, Country2),
	Country1 \= Country2,
	operates(Company, Country1),
	operates(Company, Country2),!,	% O cut está aqui para dar apenas 1 resultado
	international(CompaniesTail, ListOfCompaniesTail).

international([Company | CompaniesTail], ListOfCompanies):-
	international(CompaniesTail, ListOfCompanies).