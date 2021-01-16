%Letras maiúsculas
line(65, 0).
line(66, 1).
line(67, 2).
line(68, 3).
line(69, 4).
%Letras minúsculas
line(97, 0).
line(98, 1).
line(99, 2).
line(100, 3).
line(101, 4).

readLineAndColumnOldRing(Position):-
  write('Position of the ring that you want to move (Ex: A1, A0 to insert a new ring): '),
  read_line([Line, Column]),
  (Column == 48 ->
    Position is -1;
    line(Line, LineNumber),
    Position is LineNumber * 5 + (Column - 49)
  ).

readLineAndColumnNewRing(Position):-
  write('New position of the ring (Ex: A1): '),
  read_line([Line, Column]),
  line(Line, LineNumber),
  Position is LineNumber * 5 + (Column - 49).

readLineAndColumnOldBall(Position):-
  write('Position of the ball that you want to move (Ex: A5): '),
  read_line([Line, Column]),
  line(Line, LineNumber),
  Position is LineNumber * 5 + (Column - 49).

readLineAndColumnNewBall(Position):-
  write('New position of the ball (Ex: A1): '),
  read_line([Line, Column]),
  line(Line, LineNumber),
  Position is LineNumber * 5 + (Column - 49).

inputRing(ActualPosition, NewPosition) :-
  readLineAndColumnOldRing(ActualPosition),
  readLineAndColumnNewRing(NewPosition).

inputBall(ActualPosition, NewPosition) :-
  readLineAndColumnOldBall(ActualPosition),
  readLineAndColumnNewBall(NewPosition).

inputMenu(Mode):-
  repeat,
    write('Choose your option: '),
    read_line(Option),
    Mode is Option - 48,
    Mode > 0,
    Mode < 5.

