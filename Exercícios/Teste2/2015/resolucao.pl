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
