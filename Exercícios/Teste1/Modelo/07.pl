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

%juriFans(JuriFansList)
juriFans(JuriFansList):-
	findall(Participant, performance(Participant, _), Performed),
	createList(Performed, JuriFansList).

createList([], []).

createList([PerformedHead | PerformedTail], [PerformedHead-JuriFans | JuriFansListTail]):-
	checkJuriMembers(PerformedHead, JuriFans),
	createList(PerformedTail, JuriFansListTail).

checkJuriMembers(Participant, JuriFans):-
	performance(Participant, Times),
	addJuri(Times, JuriFans, 1).

addJuri([], [], _).

addJuri([120 | TimesTail], [N | JuriFansTail], N):-
	N1 is N + 1,
	addJuri(TimesTail, JuriFansTail, N1).

addJuri([X | TimesTail], JuriFans, N):-
	X < 120,
	N1 is N + 1,
	addJuri(TimesTail, JuriFans, N1).

toString([], '').

toString([ListHead | []], Result):-
	number_chars(ListHead, [S]),
	atom_concat(S, '', Result).

toString([ListHead | ListTail], Result):-
	toString(ListTail, TailString),
	number_chars(ListHead, [S]),
	atom_concat(S, ',', TempResult),
	atom_concat(TempResult, TailString, Result).
