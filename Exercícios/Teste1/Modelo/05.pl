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

% Não consegui fazer sem findAll
allPerfs:-
	performance(Particpant, _),
	showParticipant(Particpant),
	fail.

showParticipant(Particpant):-
	write(Particpant),
	write(':'),
	participant(Particpant, _, Name),
	write(Name),
	write(':'),
	performance(Particpant, Times),
	write('['),
	writeTimes(Times),
	write(']'),
	nl.

writeTimes([TimesHead | []]):-
	write(TimesHead).

writeTimes([TimesHead | TimesTail]):-
	TimesTail \= [],
	write(TimesHead),
	write(','),
	writeTimes(TimesTail).