:- [boards].
:- [display].
:- [menu].
:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(random)).


start:-
	repeat,
		displayMenu,
		getMenuInput(Option), nl, nl,
		handleInput(Option),
		Option =:= 4.

insertDomain([Head | []], [NewHead | []], CurrentLine):-
	length(Head, N),
	length(NewHead, N),
	UpperLimit is round(9 ** CurrentLine),
	domain(NewHead, CurrentLine, UpperLimit).

insertDomain([Head | Tail], [NewHead | NewTail], CurrentLine):-
	Tail \= [],
	length(Head, N),
	length(NewHead, N),
	UpperLimit is round(9 ** CurrentLine),
	domain(NewHead, CurrentLine, UpperLimit),
	NextLine is CurrentLine + 1,
	insertDomain(Tail, NewTail, NextLine).


insertLabeling([Head | []]):-
	labeling([], Head).

insertLabeling([Head | Tail]):-
	Tail \= [],
	labeling([], Head),
	insertLabeling(Tail).

testAll([], _).

testAll([Head | Tail], [ResultsHead | ResultsTail]):-
	(calculateBoard(Head, NewBoard),
		(ResultsHead = NewBoard ->
			write('Test Successfull'), nl;
			write('Test failed'), nl
		);
		write('Test failed'), nl
	), !,
	testAll(Tail, ResultsTail).

testAll:-
	boards(Boards),
	results(Results),
	testAll(Boards, Results).

test(Number):-
	boards(Boards),
	results(Results),
	nth0(Number, Boards, Board),
	nth0(Number, Results, Result),
	displayBoard(Board), nl,nl,
	calculateBoard(Board, NewBoard),
	write('Press enter to see result'), read_line(_), nl, nl,
	displayBoard(NewBoard),
	(Result = NewBoard ->
		write('Test Successfull'), nl;
		write('Test failed'), nl
	).

calculateBoard(Board, NewBoard):-
	length(Board, N),
	insertDomain(Board, NewBoard, 1),
	distinct(Board, NewBoard, 1, 1, N),
	restrictions(NewBoard, 2, N),
	insertLabeling(NewBoard).

distinct(Board, NewBoard, Line, Column, Size):-
	Line < Size,
	getNumber(NewBoard, Line, Column, Number),
	setDifferent(Board, NewBoard, Line, Column, 1, 1, Size, Number),
	N is Size - Line + 1,
	(Column = N ->
		NewColumn is 1,
		NewLine is Line + 1,
		distinct(Board, NewBoard, NewLine, NewColumn, Size);
		NewColumn is Column + 1,
		distinct(Board, NewBoard, Line, NewColumn, Size)
	).

distinct(Board, NewBoard, Size, 1, Size):-
	getNumber(NewBoard, Size, 1, Number),
	setDifferent(Board, NewBoard, Size, 1, 1, 1, Size, Number).

setDifferent(Board, NewBoard, Line, Column, Line, Column, Size, Number).

setDifferent(Board, NewBoard, Line, Column, Line, NewColumn, Size, Number):-
	NewColumn < Column,
	getNumber(NewBoard, Line, NewColumn, NewNumber),
	getNumber(Board, Line, Column, Color),
	getNumber(Board, Line, NewColumn, NewColor),
	(Color == NewColor ->
		(Color \= 'w' ->
			Number #= NewNumber;
			Number #\= NewNumber
		);
		Number #\= NewNumber
	),
	Column1 is NewColumn + 1,
	setDifferent(Board, NewBoard, Line, Column, Line, Column1, Size, Number).

setDifferent(Board, NewBoard, Line, Column, NewLine, NewColumn, Size, Number):-
	NewLine < Line,
	NewColumn =< Size - NewLine + 1,
	getNumber(NewBoard, NewLine, NewColumn, NewNumber),
	getNumber(Board, Line, Column, Color),
	getNumber(Board, NewLine, NewColumn, NewColor),
	(Color == NewColor ->
		(Color \= 'w' ->
			Number #= NewNumber;
			Number #\= NewNumber
		);
		Number #\= NewNumber
	),
	N is Size - NewLine + 1,
	(NewColumn = N ->
		Column1 is 1,
		Line1 is NewLine + 1,
		setDifferent(Board, NewBoard, Line, Column, Line1, Column1, Size, Number);
		Column1 is NewColumn + 1,
		setDifferent(Board, NewBoard, Line, Column, NewLine, Column1, Size, Number)
	).

restrictions(Board, Size, Size):-
	restrictions(Board, Size, 1, Size).

restrictions(Board, Line, Size):-
	Line > 1,
	Line < Size,
	restrictions(Board, Line, 1, Size),
	Line1 is Line + 1,
	restrictions(Board, Line1, Size).

restrictions(Board, Line, Column, Size):-
	Line =< Size,
	Column is Size - Line + 1,
	Line1 is Line - 1,
	Column1 is Column + 1,
	getNumber(Board, Line1, Column, Number1),
	getNumber(Board, Line1, Column1, Number2),
	N #= Number1 + Number2,
	getNumber(Board, Line, Column, N).


restrictions(Board, Line, Column, Size):-
	Line =< Size,
	Column < Size - Line + 1,
	Line1 is Line - 1,
	Column1 is Column + 1,
	getNumber(Board, Line1, Column, Number1),
	getNumber(Board, Line1, Column1, Number2),
	N #= Number1 + Number2,
	getNumber(Board, Line, Column, N),
	NewColumn is Column + 1,
	restrictions(Board, Line, NewColumn, Size).


getNumber([Number | _], 1, Number).

getNumber([_ | Tail], Column, Number):-
	Column > 1,
	NewColumn is Column - 1,
	getNumber(Tail, NewColumn, Number).

getNumber([Head | _], 1, Column, Number):-
	getNumber(Head, Column, Number).

getNumber([_ | Tail], Line, Column, Number):-
	Line > 1,
	NewLine is Line - 1,
	getNumber(Tail, NewLine, Column, Number).
