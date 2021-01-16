setBallStack(Stack, 'Whites', NewStack):-
  append([whiteBall], Stack, NewStack).

setBallStack(Stack, 'Blacks', NewStack):-
  append([blackBall], Stack, NewStack).


setBallLine([Head | Tail], Player, 0, [NewHead | Tail]):-
  setBallStack(Head, Player, NewHead).

setBallLine([Head | Tail], Player, Position, [Head | NewTail]):-
  Position > 0,
  NewPosition is Position - 1,
  setBallLine(Tail, Player, NewPosition, NewTail).

setBall([Head | Tail], Player, Position, [Head | NewTail]):-
  Position > 4,
  NewPosition is Position - 5,
  setBall(Tail, Player, NewPosition, NewTail).

setBall([Head | Tail], Player, Position, [NewHead | Tail]):-
  Position =< 4,
  setBallLine(Head, Player, Position, NewHead).

removeBallStack([whiteBall | Tail], 'Whites', [NewHead | NewTail]):-
  removeHead([whiteBall | Tail], [NewHead | NewTail]).

removeBallStack([blackBall | Tail], 'Blacks', [NewHead | NewTail]):-
  removeHead([blackBall | Tail], [NewHead | NewTail]).

removeBallLine([Head | Tail], Player, 0, [NewHead | Tail]):-
  removeBallStack(Head, Player, NewHead).

removeBallLine([Head | Tail], Player, Position, [Head | NewTail]):-
  Position > 0,
  NewPosition is Position - 1,
  removeBallLine(Tail, Player, NewPosition, NewTail).

removeBall([Head | Tail], Player, Position, [Head | NewTail]):-
  Position > 4,
  NewPosition is Position - 5,
  removeBall(Tail, Player, NewPosition, NewTail).

removeBall([Head | Tail], Player, Position, [NewHead | Tail]):-
  Position =< 4,
  removeBallLine(Head, Player, Position, NewHead).

moveBall(Board, Player, OldPosition, NewPosition, NewBoard):-
  removeBall(Board, Player, OldPosition, TempBoard),
  setBall(TempBoard, Player, NewPosition, NewBoard).
