displayBoard([]).

displayBoard([Head | Tail]) :-
	Head \= [],
    displayLine(Head), nl,
    displayBoard(Tail).

displayLine([]).

displayLine([Head | []]):-
	Head \= [],
	write(Head), nl.

displayLine([Head | Tail]):-
	Tail \= [],
	write(Head),
	write(' | '),
	displayLine(Tail).