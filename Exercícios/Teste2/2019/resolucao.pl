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


prat(Prateleiras, Objetos, Vars):-
	length(Objetos, N),
	length(Vars, N),
	comprimento(Prateleiras, Comprimento),
	length(Prateleiras, Altura),
	Domain is Comprimento * Altura,
	domain(Vars, 1, Domain),

	get_tasks(Objetos, Vars, Tasks),
	append(Prateleiras, Armario),
	get_machines(Armario, Machines, 1),
	cumulatives(Tasks, Machines,  [bound(upper)]),

	length(Pesos, Domain),
	get_pesos(Objetos, Vars, Pesos, 1),
	set_pesos(Pesos, Comprimento, 1),

	labeling([], Vars).

comprimento([P | _], Comprimento):-
	length(P, Comprimento).

get_tasks([], [], []).
get_tasks([_-OVolume | Objetos], [V | Vars], [T | Tasks]):-
	T = task(0, OVolume, OVolume, OVolume, V),
	get_tasks(Objetos, Vars, Tasks).

get_machines([],[],_).
get_machines([P | Prateleiras], [M | Machines], Id):-
	M = machine(Id, P),
	Next is Id + 1,
	get_machines(Prateleiras, Machines, Next).

get_peso([], [], 0, _).
get_peso([O-_ | Objetos], [V | Vars], Peso, Current):-
	(V #= Current) #<=> Bool,
	Peso #= Bool * O + Temp,
	get_peso(Objetos, Vars, Temp, Current).

get_pesos(_, _, [], _).
get_pesos(Objetos, Vars, [P | Pesos], Current):-
	get_peso(Objetos, Vars, P, Current),
	Next is Current + 1,
	get_pesos(Objetos, Vars, Pesos, Next).

set_pesos(Pesos, Comprimento, Current):-
	length(Pesos, N),
	Current is N - Comprimento + 1.
set_pesos(Pesos, Comprimento, Current):-
	Baixo is Current + Comprimento,
	element(Current, Pesos, P1),
	element(Baixo, Pesos, P2),
	P1 #=< P2,
	Next is Current + 1,
	set_pesos(Pesos, Comprimento, Next).


objeto(piano, 3, 30).
objeto(cadeira, 1, 10).
objeto(cama, 3, 15).
objeto(mesa, 2, 15).
homens(4).
tempo_max(60).

furniture:-
	homens(Homens),
	tempo_max(Tempo),
	findall(Nome-Pessoas-Duracao, objeto(Nome, Pessoas, Duracao), Objetos),
	length(Objetos, N),
	length(StartingTimes, N),
	length(EndingTimes, N),
	domain(StartingTimes, 0, Tempo),
	domain(EndingTimes, 0, Tempo),

	get_tasks(Objetos, StartingTimes, EndingTimes, Tasks),
	cumulative(Tasks, [limit(Homens)]), % Resolve todas as tasks de forma a que o consumo nunca execeda o limit em nenhum momento.
	labeling([], StartingTimes),
	labeling([], EndingTimes),
	findall(_, (nth1(Index, Objetos, ON-_-_), nth1(Index, StartingTimes, ST), nth1(Index, EndingTimes, ET), write(ON-ST-ET), nl), _).

get_tasks([], [], [], []).
get_tasks([ON-OP-OD | Objetos], [ST | StartingTimes], [ET | EndingTimes], [T | Tasks]):-
	T = task(ST, OD, ET, OP, ON),	% task(Tempo Inicial, Duração, Tempo Final, Consumo, Id)
	get_tasks(Objetos, StartingTimes, EndingTimes, Tasks).