:- use_module(library(random)).
:- use_module(library(lists)).

% valid_moves(+GameState, +Player, -ListOfMoves).
% GameState é [Board, WhiteRings, BlackRings]
valid_moves([Board, _, BlackRings], 'Blacks', Moves):-
	findRing(Board, 'Blacks', RingPositions),
	(BlackRings > 0 ->
	    append([-1], RingPositions, InitialRingPositions);
		append(RingPositions, [], InitialRingPositions)
	),
	ballPosition(Board, 'Blacks', InitialRingPositions, Moves).

valid_moves([Board, WhiteRings, _], 'Whites', Moves):-
	findRing(Board, 'Whites', RingPositions),
	(WhiteRings > 0 ->
	    append([-1], RingPositions, InitialRingPositions);
		append(RingPositions, [], InitialRingPositions)
	),
	ballPosition(Board, 'Whites', InitialRingPositions, Moves).

ballPosition(Board, Player, InitialRingPositions, Moves):-
	findBalls(Board, Player, BallPositions),
	findFinalBallPositions(Board, Player, InitialRingPositions, BallPositions, Moves).

findFinalBallPositions(_, _, [], []).

findFinalBallPositions(Board, Player, InitialRingPositions, InitialBallPositions, Moves):-
	findall([InitialRingPosition, RingPosition, InitialBallPosition, BallPosition], (
		member(InitialBallPosition, InitialBallPositions),
		member(InitialRingPosition, InitialRingPositions),
		possibleMoves(Board,Player, InitialRingPosition, InitialBallPosition,RingPosition,BallPosition)
		), Moves).

possibleMoves(Board, Player, InitialRingPosition, InitialBallPosition, RingPosition, BallPosition):-
	wrongPositions(RingPosition),
	wrongPositions(BallPosition),
	ringWithoutBall(Board, RingPosition),
	moveRing(Board, Player, InitialRingPosition, RingPosition, 1, NewBoard, _),
	canMoveBall(NewBoard, InitialBallPosition, BallPosition, Player).

findBalls(Board, 'Blacks', BallPositions):-
	findall(Position, (wrongPositions(Position), head(Board, Position, blackBall)), BallPositions).
findBalls(Board, 'Whites', BallPositions):-
	findall(Position, (wrongPositions(Position), head(Board, Position, whiteBall)), BallPositions).

ringPositions(Board, Position):-
	wrongPositions(Position),
	ringWithoutBall(Board, Position).

findRing(Board, 'Blacks', RingPosition):-
	findall(Position, (wrongPositions(Position), head(Board, Position, blackRing)), RingPosition).
findRing(Board, 'Whites', RingPosition):-
	findall(Position, (wrongPositions(Position), head(Board, Position, whiteRing)), RingPosition).

% choose_move(+GameState, +Player, +Level, -Move).
% GameState é [Board, WhiteRings, BlackRings]
choose_move([Board, WhiteRings, BlackRings], Player, Level, Move):-
	(Level == 'Easy' ->
		valid_moves([Board, WhiteRings, BlackRings], Player, PossibleMoves),
		length(PossibleMoves,Length),
		random(0,Length,Value),
		nth0(Value,PossibleMoves,Move);
		valid_moves([Board, WhiteRings, BlackRings], Player, PossibleMoves),
		findall([Value, TempMove], (member(TempMove, PossibleMoves), valueFromMove(Board, Player, TempMove, Value)), Values),
		minValue(Values, MinValue, Move)
	).

minValue([], 100, []).

minValue([[Value, Move] | Values], MinValue, BestMove):-
	minValue(Values, TempMin, TempMove),
	(Value < TempMin ->
		MinValue is Value,
		BestMove = Move;
		MinValue is TempMin,
		BestMove = TempMove
	).

valueFromMove(Board, Player, Move, Value):-
	nextBoard(Board, Player, Move, NewBoard),
	value(NewBoard, Player, Value).

nextBoard(Board, Player, [ActualRingPosition, NewRingPosition, ActualBallPosition, NewBallPosition], NewBoard):-
	moveRing(Board, Player, ActualRingPosition, NewRingPosition, 2, MiddleBoard, _),
	moveBall(MiddleBoard, Player, ActualBallPosition, NewBallPosition, NewBoard).

%value(+GameState, +Player, -Value).
% Neste caso GameState é o Board
value(GameState, Player, Value):-
	(Player == 'Blacks' ->
		findBalls(GameState, 'Blacks', BallPositions),
		findall(Distance, (member(BallPosition, BallPositions) ,distance(BallPosition, 20, Distance)), Distances),
		sumlist(Distances, Value);
		findBalls(GameState, 'Whites', BallPositions),
		findall(Distance, (member(BallPosition, BallPositions) ,distance(BallPosition, 4, Distance)), Distances),
		sumlist(Distances, Value)
	).

distance(Position1, Position2, Result):-
	Position1Line is Position1 // 5,
	Position1Column is Position1 mod 5,
	Position2Line is Position2 // 5,
	Position2Column is Position2 mod 5,
	Result is sqrt((Position2Line - Position1Line)^2 + (Position2Column - Position1Column)^2).