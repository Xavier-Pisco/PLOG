:- use_module(library(lists)).
:- use_module(library(between)).
:- use_module(library(clpfd)).

prog1(N, M, L1, L2):-
	length(L1,N),
	N1 is N - 1, length(L2, N1),
	findall(E, between(1, M, E), LE),
	fill(L1, LE, LE_),
	fill(L2, LE_, _),
	check(L1, L2).

fill([], LEf, LEf).
fill([X | Xs], LE, LEf):-
	select(X, LE, LE_),
	fill(Xs, LE_, LEf).

check([_], []).
check([A, B | R], [X | Xs]):-
	A + B =:= X,
	check([B | R], Xs).

prog2(N, M, L1, L2):-
	length(L1, N),
	N1 is N - 1, length(L2, N1),
	domain(L1, 1, M),
	domain(L2, 1, M),
	append(L1, L2, L3),
	all_distinct(L3),
	check2(L1, L2),
	labeling([], L1).

check2([_], []).
check2([A, B | R], [X | Xs]):-
	A + B #= X,
	check2([B | R], Xs).


gym_pairs(ManHeights, WomenHeights, Delta, Pairs):-
	length(ManHeights, Men),
	length(WomenHeights, Women),
	Men =:= Women,
	length(Pairs, Men),
	length(Pair, Men), % List of all mans and cotains the indice of the woman
	domain(Pair, 1, Men),
	all_distinct(Pair),
	setHeights(ManHeights, WomenHeights, Delta, Pair, 1),
	labeling([], Pair),
	prepare(Pair, Pairs, 1). % Just change output from a single list to a list with pairs

setHeights(_, _, _, [], _).
setHeights(ManHeights, WomenHeights, Delta, [PH | PT], Current):-
	nth1(Current, ManHeights, ManHeigth),
	nth1(X, WomenHeights, WomenHeight), % Tries any womenHeight for the curren manHeight
	0 =< ManHeigth - WomenHeight,
	Delta >= ManHeigth - WomenHeight,
	PH #= X,	% If heights are compatible then the pair number is the number of the women
	Next is Current + 1,
	setHeights(ManHeights, WomenHeights, Delta, PT, Next).
setHeights(ManHeights, WomenHeights, Delta, [PH | PT], Current):-
	PH #= 0,
	Next is Current + 1,
	setHeights(ManHeights, WomenHeights, Delta, PT, Next).

prepare([],[],_).
prepare([PH | PT], [PSH | PST], Current):-
	PSH = Current-PH,
	Next is Current + 1,
	prepare(PT, PST, Next).

optimal_skating_pairs(ManHeights, WomenHeights, Delta, Pairs):-
	length(ManHeights, Men),
	length(WomenHeights, Women),
	length(Pair, Men),
	domain(Pair, 0, Women),
	all_distinct_except_0(Pair),
	setHeights(ManHeights, WomenHeights, Delta, Pair, 1),
	countNonZeros(Pair, Number),
	labeling([maximize(Number)], Pair),
	prepare2(Pair, Pairs, 1). % Just change output from a single list to a list with pairs

countNonZeros([], 0).
countNonZeros([PH | PT], Number):-
	countZeros(PT, Temp),
	(PH is 0, Number is Temp; Number is Temp + 1).

prepare2([],[],_).
prepare2([0 | PT], Pairs, Current):-
	Next is Current + 1,
	prepare2(PT, Pairs, Next).
prepare2([PH | PT], [PSH | PST], Current):-
	PH \= 0,
	PSH = Current-PH,
	Next is Current + 1,
	prepare2(PT, PST, Next).