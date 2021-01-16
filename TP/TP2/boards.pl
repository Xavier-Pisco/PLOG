first([[r, r, y, w, g], [y, w, w, w], [w, g, w], [w, w], [w]]).

second([[r, w, y, y, w], [w, w, r, w], [w, w, g], [g, w], [w]]).

testBoard([[r,w,w,w,w,r],[y,w,w,y,w],[w,w,w,g],[g,w,w],[w,w],[w]]).

boards([
	[[r, r, y, w, g], [y, w, w, w], [w, g, w], [w, w], [w]],
	[[r, w, y, y, w], [w, w, r, w], [w, w, g], [g, w], [w]],
	[[r, y, w, g, g], [w, w, y, w], [w, r, w], [w, w], [w]],
	[[w, r, r, y, y], [w, w, w, w], [g, w, w], [w, g], [w]],
	[[r, y, y, w, r], [w, w, w, w], [w, w, g], [g, w], [w]],
	[[r, y, y, w, g], [w, w, w, w], [g, r, w], [w, w], [w]],
	[[r, w, y, y, w], [w, r, w, w], [g, w, w], [w, g], [w]],
	[[r, w, w, r, y], [w, w, w, w], [w, y, g], [g, w], [w]],
	[[w, w, w, w, r], [y, w, r, g], [g, y, w], [w, w], [w]],
    [[r, r, w, w, w, y], [w, w, w, w, w], [y, w, w, g], [w, g, w], [w, w], [w]],
    [[r, y, w, r, w, y], [w, w, w, w, w], [g, w, w, w], [w, w, g], [w, w], [w]],
    [[r, w, w, w, w, r], [y, w, w, y, w], [w, w, w, g], [g, w, w], [w, w], [w]],
    [[w, r, w, w, w, w], [y, w, w, w, r], [w, g, y, w], [w, w, g], [w, w], [w]]
]).

results([
	[[1, 1, 2, 4, 9], [2, 3, 6, 13], [5, 9, 19], [14, 28], [42]],
	[[4, 1, 2, 2, 9], [5, 3, 4, 11], [8, 7, 15], [15, 22], [37]],
	[[9, 4, 1, 3, 3], [13, 5, 4, 6], [18, 9, 10], [27, 19], [46]],
	[[9, 5, 5, 1, 1], [14, 10, 6, 2], [24, 16, 8], [40, 24], [64]],
    [[9, 1, 1, 5, 9], [10, 2, 6, 14], [12, 8, 20], [20, 28], [48]],
	[[6, 1, 1, 3, 9], [7, 2, 4, 12], [9, 6, 16], [15, 22], [37]],
    [[9, 7, 2, 2, 6], [16, 9, 4, 8], [25, 13, 12], [38, 25], [63]],
	[[4, 2, 1, 4, 8], [6, 3, 5, 12], [9, 8, 17], [17, 25], [42]],
    [[8, 2, 1, 6, 7], [10, 3, 7, 13], [13, 10, 20], [23, 30], [53]],
	[[2, 2, 1, 5, 8 , 7], [4, 3, 6, 13, 15], [7, 9, 19, 28], [16, 28, 47], [44, 75], [119]],
	[[3, 9, 8, 3, 1, 9], [12, 17, 11, 4, 10], [29, 28, 15, 14], [57, 43, 29], [100, 72], [172]],
	[[8, 2, 4, 1, 9, 8], [10, 6, 5, 10, 17], [16, 11, 15, 27], [27, 26, 42], [53, 68], [121]],
	[[9, 6, 8, 3, 1, 5], [15, 14, 11, 4, 6], [29, 25, 15, 10], [54, 40, 25], [94, 65], [159]]
]).

positions(1, 1).
positions(1, 2).
positions(1, 3).
positions(1, 4).
positions(1, 5).
positions(2, 1).
positions(2, 2).
positions(2, 3).
positions(2, 4).
positions(3, 1).
positions(3, 2).
positions(3, 3).
positions(4, 1).
positions(4, 2).
positions(5, 1).

generate(Size, Result):-
	repeat,
		generateBoard(Board, Size, Result),
		displayBoard(Board), nl, nl.

generateBoard(Board, Size, Result):-
	findall([Line, Column], positions(Line, Column), Positions1),
	length(Positions1, N1),
	random(1, N1, Index1),
	nth1(Index1, Positions1, RedPosition1),
	findall([Line, Column], (
		positions(Line, Column),
		differentPositions(RedPosition1, [Line, Column])), Positions2),
	length(Positions2, N2),
	random(1, N2, Index2),
	nth1(Index2, Positions2, RedPosition2),
	findall([Line, Column], (
		positions(Line, Column),
		differentPositions(RedPosition1, [Line, Column]),
		differentPositions(RedPosition2, [Line, Column])), Positions3),
	length(Positions3, N3),
	random(1, N3, Index3),
	nth1(Index3, Positions3, GreenPosition1),
	findall([Line, Column], (
		positions(Line, Column),
		differentPositions(RedPosition1, [Line, Column]),
		differentPositions(RedPosition2, [Line, Column]),
		differentPositions(GreenPosition1, [Line, Column])), Positions4),
	length(Positions4, N4),
	random(1, N4, Index4),
	nth1(Index4, Positions4, GreenPosition2),
	findall([Line, Column], (
		positions(Line, Column),
		differentPositions(RedPosition1, [Line, Column]),
		differentPositions(RedPosition2, [Line, Column]),
		differentPositions(GreenPosition1, [Line, Column]),
		differentPositions(GreenPosition2, [Line, Column])), Positions5),
	length(Positions5, N5),
	random(1, N5, Index5),
	nth1(Index5, Positions5, YellowPosition1),
	findall([Line, Column], (
		positions(Line, Column),
		differentPositions(RedPosition1, [Line, Column]),
		differentPositions(RedPosition2, [Line, Column]),
		differentPositions(GreenPosition1, [Line, Column]),
		differentPositions(GreenPosition2, [Line, Column]),
		differentPositions(YellowPosition1, [Line, Column])), Positions6),
	length(Positions6, N6),
	random(1, N6, Index6),
	nth1(Index6, Positions6, YellowPosition2),
	createBoard(RedPosition1, RedPosition2, GreenPosition1, GreenPosition2, YellowPosition1, YellowPosition2, 1, Size, Board),
	calculateBoard(Board, Result).

createBoard(RedPosition1, RedPosition2, GreenPosition1, GreenPosition2, YellowPosition1, YellowPosition2, Line, Line, [BoardHead | BoardTail]):-
	createBoardLine(RedPosition1, RedPosition2, GreenPosition1, GreenPosition2, YellowPosition1, YellowPosition2, Line, 1, Line, BoardHead),
	BoardTail = [].

createBoard(RedPosition1, RedPosition2, GreenPosition1, GreenPosition2, YellowPosition1, YellowPosition2, Line, Size, [BoardHead | BoardTail]):-
	Line < Size,
	createBoardLine(RedPosition1, RedPosition2, GreenPosition1, GreenPosition2, YellowPosition1, YellowPosition2, Line, 1, Size, BoardHead),
	NewLine is Line + 1,
	createBoard(RedPosition1, RedPosition2, GreenPosition1, GreenPosition2, YellowPosition1, YellowPosition2, NewLine, Size, BoardTail).


createBoardLine([Line, Column], RedPosition2, GreenPosition1, GreenPosition2, YellowPosition1, YellowPosition2, Line, Column, Size, [LineHead | LineTail]):-
	Line =< Size,
	N is Size - Line + 1,
	(Column = N ->
		LineHead = 'r',
		LineTail = [];
		(Column < N ->
			LineHead = 'r',
			NewColumn is Column + 1,
			createBoardLine([Line, Column], RedPosition2, GreenPosition1, GreenPosition2, YellowPosition1, YellowPosition2, Line, NewColumn, Size, LineTail)
		)
	).

createBoardLine(RedPosition1, [Line, Column], GreenPosition1, GreenPosition2, YellowPosition1, YellowPosition2, Line, Column, Size, [LineHead | LineTail]):-
	Line =< Size,
	N is Size - Line + 1,
	(Column = N ->
		LineHead = 'r',
		LineTail = [];
		(Column < N ->
			LineHead = 'r',
			NewColumn is Column + 1,
			createBoardLine(RedPosition1, [Line, Column], GreenPosition1, GreenPosition2, YellowPosition1, YellowPosition2, Line, NewColumn, Size, LineTail)
		)
	).

createBoardLine(RedPosition1, RedPosition2, [Line, Column], GreenPosition2, YellowPosition1, YellowPosition2, Line, Column, Size, [LineHead | LineTail]):-
	Line =< Size,
	N is Size - Line + 1,
	(Column = N ->
		LineHead = 'g',
		LineTail = [];
		(Column < N ->
			LineHead = 'g',
			NewColumn is Column + 1,
			createBoardLine(RedPosition1, RedPosition2, [Line, Column], GreenPosition2, YellowPosition1, YellowPosition2, Line, NewColumn, Size, LineTail)
		)
	).

createBoardLine(RedPosition1, RedPosition2, GreenPosition1,[Line, Column], YellowPosition1, YellowPosition2, Line, Column, Size, [LineHead | LineTail]):-
	Line =< Size,
	N is Size - Line + 1,
	(Column = N ->
		LineHead = 'g',
		LineTail = [];
		(Column < N ->
			LineHead = 'g',
			NewColumn is Column + 1,
			createBoardLine(RedPosition1, RedPosition2, GreenPosition1, [Line, Column], YellowPosition1, YellowPosition2, Line, NewColumn, Size, LineTail)
		)
	).

createBoardLine(RedPosition1, RedPosition2, GreenPosition1, GreenPosition2, [Line, Column], YellowPosition2, Line, Column, Size, [LineHead | LineTail]):-
	Line =< Size,
	N is Size - Line + 1,
	(Column = N ->
		LineHead = 'y',
		LineTail = [];
		(Column < N ->
			LineHead = 'y',
			NewColumn is Column + 1,
			createBoardLine(RedPosition1, RedPosition2, GreenPosition1, GreenPosition2, [Line, Column], YellowPosition2, Line, NewColumn, Size, LineTail)
		)
	).

createBoardLine(RedPosition1, RedPosition2, GreenPosition1, GreenPosition2, YellowPosition1, [Line, Column], Line, Column, Size, [LineHead | LineTail]):-
	Line =< Size,
	N is Size - Line + 1,
	(Column = N ->
		LineHead = 'y',
		LineTail = [];
		(Column < N ->
			LineHead = 'y',
			NewColumn is Column + 1,
			createBoardLine(RedPosition1, RedPosition2, GreenPosition1, GreenPosition2, YellowPosition1, [Line, Column], Line, NewColumn, Size, LineTail)
		)
	).


createBoardLine(RedPosition1, RedPosition2, GreenPosition1, GreenPosition2, YellowPosition1, YellowPosition2, Line, Column, Size, [LineHead | LineTail]):-
	Line =< Size,
	N is Size - Line + 1,
	Column = N,
	RedPosition1 \= [Line, Column],
	RedPosition2 \= [Line, Column],
	GreenPosition1 \= [Line, Column],
	GreenPosition2 \= [Line, Column],
	YellowPosition1 \= [Line, Column],
	YellowPosition2 \= [Line, Column],
	LineHead = 'w',
	LineTail = [].

createBoardLine(RedPosition1, RedPosition2, GreenPosition1, GreenPosition2, YellowPosition1, YellowPosition2, Line, Column, Size, [LineHead | LineTail]):-
	Line =< Size,
	N is Size - Line + 1,
	Column < N,
	RedPosition1 \= [Line, Column],
	RedPosition2 \= [Line, Column],
	GreenPosition1 \= [Line, Column],
	GreenPosition2 \= [Line, Column],
	YellowPosition1 \= [Line, Column],
	YellowPosition2 \= [Line, Column],
	LineHead = 'w',
	NewColumn is Column + 1,
	createBoardLine(RedPosition1, RedPosition2, GreenPosition1, GreenPosition2, YellowPosition1, YellowPosition2, Line, NewColumn, Size, LineTail).


differentPositions([Line1, Column1], [Line2, Column2]):-
	Line1 \= Line2.


differentPositions([Line, Column1], [Line, Column2]):-
	Column1 \= Column2.