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

juriTimes([], _, [], 0).

%juriTimes(+Participants, +JuriMember, -Times, -Total)
juriTimes([ParticipantsHead | ParticipantsTail], JuriMember, [TimesHead | TimesTail], Total):-
	performance(ParticipantsHead, Juri),
	getTimeJuriMember(Juri, JuriMember, TimesHead),
	juriTimes(ParticipantsTail, JuriMember, TimesTail, SubTotal),
	Total is TimesHead + SubTotal.

getTimeJuriMember([Head | Tail], 1, Time):-
	Time is Head.

getTimeJuriMember([Head | Tail], N, Time):-
	N > 1,
	N1 is N - 1,
	getTimeJuriMember(Tail, N1, Time).