:- use_module(library(clpfd)).
:- use_module(library(lists)).

embrulha(Rolos, Presentes, RolosSelecionados):-
	length(Rolos, N1),
	length(Presentes, N2),
	length(RolosSelecionados, N2),
	domain(RolosSelecionados, 1, N1),
	setSizes(Rolos, Presentes, RolosSelecionados),
	labeling([], RolosSelecionados).

setSizes(_, [], []).
setSizes(Rolos, [PH | PT], [RH | RT]):-
	useRolo(Rolos, PH, RH, NewRolos),
	verify(NewRolos),
	setSizes(NewRolos, PT, RT).

useRolo([RH | RT], Presente, 1, [NRH | RT]):-
	NRH is RH - Presente.
useRolo([RH | RT], Presente, Selecionado, [RH | NRT]):-
	Selecionado #> 1,
	NewSelecionado #= Selecionado - 1,
	useRolo(RT, Presente, NewSelecionado, NRT).

verify([]).
verify([RH | RT]):-
	RH >= 0,
	verify(RT).