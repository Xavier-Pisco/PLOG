setRingStack(Stack, 'Whites', NewStack):-
  append([whiteRing], Stack, NewStack).

setRingStack(Stack, 'Blacks', NewStack):-
  append([blackRing], Stack, NewStack).

setRingLine([Head | Tail], Player, 0, [NewHead | Tail]):-
  setRingStack(Head, Player, NewHead).

setRingLine([Head | Tail], Player, Position, [Head | NewTail]):-
  Position > 0,
  NewPosition is Position - 1,
  setRingLine(Tail, Player, NewPosition, NewTail).

setRing([Head | Tail], Player, Position , [Head | NewTail]):-
  Position > 4,
  NewPosition is Position - 5,
  setRing(Tail, Player, NewPosition, NewTail).

setRing([Head | Tail], Player, Position, [NewHead | Tail]):-
  Position =< 4,
  setRingLine(Head, Player, Position, NewHead).

removeRingStack([whiteRing | Tail], 'Whites', [NewHead | NewTail]):-
  removeHead([whiteRing | Tail], [NewHead | NewTail]).

removeRingStack([blackRing | Tail], 'Blacks', [NewHead | NewTail]):-
  removeHead([blackRing | Tail], [NewHead | NewTail]).

removeRingLine([Head | Tail], Player, 0, [NewHead | Tail]):-
  removeRingStack(Head, Player, NewHead).

removeRingLine([Head | Tail], Player, Position, [Head | NewTail]):-
  Position > 0,
  NewPosition is Position - 1,
  removeRingLine(Tail, Player, NewPosition, NewTail).

removeRing([Head | Tail], Player, Position, [Head | NewTail]):-
  Position > 4,
  NewPosition is Position - 5,
  removeRing(Tail, Player, NewPosition, NewTail).

removeRing([Head | Tail], Player, Position, [NewHead | Tail]):-
  Position =< 4,
  removeRingLine(Head, Player, Position, NewHead).

moveRing(Board, Player, -1, NewPosition, Rings, NewBoard, NewRings):-
  Rings > 0,
  NewRings is Rings - 1,
  setRing(Board, Player, NewPosition, NewBoard).

moveRing(Board, Player, OldPosition, NewPosition, Rings, NewBoard, NewRings):-
  OldPosition > -1,
  NewRings is Rings,
  removeRing(Board, Player, OldPosition, TempBoard),
  setRing(TempBoard, Player, NewPosition, NewBoard).
