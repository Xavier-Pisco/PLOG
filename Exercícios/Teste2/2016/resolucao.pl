:- use_module(library(clpfd)).
:- use_module(library(lists)).

concelho(x,120,410).
concelho(y,10,800).
concelho(z,543,2387).
concelho(w,3,38).
concelho(k,234,376).

concelhos(NDias, MaxDist, ConcelhosVisitados, DistTotal, TotalEleitores):-
	findall(Nome, concelho(Nome, _, _), Nomes),
	findall(Distancia, concelho(_, Distancia, _), Distancias),
	findall(Eleitor, concelho(_, _, Eleitor), Eleitores),
	length(Nomes, N),

	length(Temp, N),
	domain(Temp, 0, 1),
	count(1, Temp, #=, Dias),
	Dias #=< NDias,
	scalar_product(Eleitores, Temp, #=, TotalEleitores),
	scalar_product(Distancias, Temp, #=, DistTotal),
	DistTotal #=< MaxDist,
	labeling([maximize(TotalEleitores)], Temp),

	length(ConcelhosVisitados, Dias),
	findall(Concelho, (nth1(Indice, Temp, 1), nth1(Indice, Nomes, Concelho)), ConcelhosVisitados).