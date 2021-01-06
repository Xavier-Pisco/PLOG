:- use_module(library(clpfd)).
:- use_module(library(lists)).

/*
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
*/

embrulha(Rolos, Presentes, RolosSelecionados):-
	length(Rolos, N1),
	length(Presentes, N2),
	length(RolosSelecionados, N2),
	domain(RolosSelecionados, 1, N1),

    getTasks(Presentes, RolosSelecionados, Tasks),
    getMachines(Rolos, Machines, 1),
    cumulatives(Tasks, Machines, [bound(upper)]),  
    /* 
    Verifica para todas as Tasks se Fim = Início + Duração.
    Verifica se para todas as tasks com o mesmo Id de máquina (neste caso com o mesmo RoloSelecionado)
    a máquina com esse Id (neste caso o Rolo) cumpre o limite imposto.
    O limite pode ser upper ou lower, no caso de ser upper significa que a máquina tem limite suficiente para todas,
    no caso de ser lower significa que as tasks utilizam mais do que a máquina tem.
    */
    labeling([], RolosSelecionados).


getTasks([],[],[]).
getTasks([P | Presentes], [R | RolosSelecionados], [T | Tasks]):-
    T = task(0, P, P, P, R), % task define-se através de task(Início, Duração, Fim, Consumo, Id Máquina)
    getTasks(Presentes, RolosSelecionados, Tasks).

getMachines([], [], _).
getMachines([R | Rolos], [M | Machines], Id):-
    M = machine(Id, R),  % Machine define-se através de machine(Id Máquina, Limite recurso)
    Next is Id + 1,
    getMachines(Rolos, Machines, Next).
