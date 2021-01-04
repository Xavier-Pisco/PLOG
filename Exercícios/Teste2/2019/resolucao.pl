:- use_module(library(clpfd)).
:- use_module(library(lists)).

pres(N, K, Vars):-
	length(Vars, N),
	domain(Vars, 1, K),
	%
	indices(1, Vars),
	%
	labeling([], Vars).

indices(I, [V | Vs]):-
	V mod 2 #\= I mod 2,
	I1 is I + 1,
	indices(I1, Vs).

indices(_, []).

constroi_binarias(I, K, Vars, [LBin | LBins]):-
	I =< K, !,
	constroi_bins(I, Vars, LBin),
	I1 is I+1,
	constroi_binarias(I1, K, Vars, LBins).
constroi_binarias(_,_,_,[]).

constroi_bins(_, [], []).
constroi_bins(I, [VH | VT], [LBinH | LBinT]):-
	I #= VH,
	LBinH #= VH,
	constroi_bins(I, VT, LBinT).
constroi_bins(I, [VH | VT], LBin):-
	VH #\= I,
	constroi_bins(I, VT, LBin).
