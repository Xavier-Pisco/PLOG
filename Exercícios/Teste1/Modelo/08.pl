:- use_module(library(lists)).

%participant(Id,Age,Performance)
participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').

%performance(Id,Times)
performance(1234,[120,120,120,120]).
performance(3423,[32,120,45,120]).
performance(3788,[110,2,6,43]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).

/** As próximas funções são de exercicios anteriores
que foram precisas para fazer este exercicio */
checkTime([H|_]):-
    H == 120.

checkTime([H|T]):-
    H < 120,
    checkTime(T).

madeItThrough(Id):-
    performance(Id, L),
    checkTime(L).

eligibleOutcome(Id,Perf,TT) :-
    performance(Id,Times),
    madeItThrough(Id),
    participant(Id,_,Perf),
    sumlist(Times,TT).
/** Este exexrcício começa aqui */

% nextPhase(+N, -Participants)
nextPhase(0, []).
nextPhase(0, [], _).

nextPhase(N, [ParticipantsHead | ParticipantsTail]):-
	N > 0,
	findall(Id ,eligibleOutcome(Id, _, _), EligibleParticipants),
	length(Participants, X),
	X >= N, !,
	bestParticipant(EligibleParticipants, BestParticipant, _),
	N1 is N - 1,
	removeBest(EligibleParticipants, BestParticipant, NewEligibleParticipants),
	eligibleOutcome(BestParticipant, BestPerf, BestTT),
	ParticipantsHead = [BestTT, BestParticipant, BestPerf],
	nextPhase(N1, ParticipantsTail, NewEligibleParticipants).

nextPhase(N, [ParticipantsHead | ParticipantsTail], EligibleParticipants):-
	N > 0,
	bestParticipant(EligibleParticipants, BestParticipant, _),
	N1 is N - 1,
	removeBest(EligibleParticipants, BestParticipant, NewEligibleParticipants),
	eligibleOutcome(BestParticipant, BestPerf, BestTT),
	ParticipantsHead = [BestTT, BestParticipant, BestPerf],
	nextPhase(N1, ParticipantsTail, NewEligibleParticipants).

removeBest([Participant | ParticipantsTail], Participant, ParticipantsTail).
removeBest([ParticipantsHead | ParticipantsTail], Participant, [ParticipantsHead | NewParticipantsTail]):-
	removeBest(ParticipantsTail, Participant, NewParticipantsTail).


bestParticipant([], 0, 0).

bestParticipant([Id | ParticipantsTail], BestId, BestTT):-
	bestParticipant(ParticipantsTail, TailBestId, TailBestTT),
	eligibleOutcome(Id, Perf, TT),
	(TT > TailBestTT ->
		BestId is Id,
		BestTT is TT;
		BestId is TailBestId,
		BestTT is TailBestTT
	).