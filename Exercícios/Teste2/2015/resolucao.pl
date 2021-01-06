:- use_module(library(clpfd)).
:- use_module(library(lists)).

distribute(Domains, Vars):-
	length(Domains, N),
	length(Vars, N),
	start_vars(Domains, Vars),
	set_different(Vars),
	labeling([], Vars).

start_vars([], []).
start_vars([D | Domains], [V | Vars]):-
	list_to_fdset(D, Set),
	V in_set Set,
	start_vars(Domains, Vars).

set_different([_]).
set_different([V1, V2 | Vars]):-
	V1 #\= V2,
	set_different([V2 | Vars]).

distribute(NBags, Domains, MinObj, MaxObj, Vars):-
	length(Domains, N),
	length(Vars, N),
	start_vars(NBags, Domains, Vars),
	set_min_max(NBags, MinObj, MaxObj, Vars),
	labeling([], Vars).

start_vars(_, [], []).
start_vars(NBags, [D | Domains], [V |  Vars]):-
	list_to_fdset(D, Set),
	V in_set Set,
	V #=< NBags,
	start_vars(NBags, Domains, Vars).

set_min_max(0, _, _, _).
set_min_max(NBags, MinObj, MaxObj, Vars):-
	NBags > 0,
	count(NBags, Vars, #=, Times),
	Times #= 0 #\/ (Times #=< MaxObj #/\ Times #>= MinObj),
	NBags1 is NBags - 1,
	set_min_max(NBags1, MinObj, MaxObj, Vars).