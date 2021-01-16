wrongPositions(0).
wrongPositions(1).
wrongPositions(2).
wrongPositions(3).
wrongPositions(4).
wrongPositions(5).
wrongPositions(6).
wrongPositions(7).
wrongPositions(8).
wrongPositions(9).
wrongPositions(10).
wrongPositions(11).
wrongPositions(12).
wrongPositions(13).
wrongPositions(14).
wrongPositions(15).
wrongPositions(16).
wrongPositions(17).
wrongPositions(18).
wrongPositions(19).
wrongPositions(20).
wrongPositions(21).
wrongPositions(22).
wrongPositions(23).
wrongPositions(24).

ballWithRingStack([Head | _],'Whites'):-
  Head == whiteRing.

ballWithRingStack([Head | _],'Blacks'):-
  Head == blackRing.

ballWithRingLine([Head | _], Player, 0):-
  ballWithRingStack(Head, Player).


ballWithRingLine([_ | Tail], Player, Position):-
  Position > 0,
  NewPosition is Position - 1,
  ballWithRingLine(Tail, Player, NewPosition).

ballWithRing([_ | Tail], Player, Position):-
  Position > 4,
  NewPosition is Position - 5,
  ballWithRing(Tail, Player, NewPosition).

ballWithRing([Head | _], Player, Position):-
  Position =< 4,
  ballWithRingLine(Head, Player, Position).


ringWithoutBallStack([Head | _]):-
  Head \= whiteBall,
  Head \= blackBall.

ringWithoutBallLine([Head | _], 0):-
  ringWithoutBallStack(Head).


ringWithoutBallLine([_ | Tail], Position):-
  Position > 0,
  NewPosition is Position - 1,
  ringWithoutBallLine(Tail, NewPosition).

ringWithoutBall([_ | Tail], Position):-
  Position > 4,
  NewPosition is Position - 5,
  ringWithoutBall(Tail, NewPosition).

ringWithoutBall([Head | _], Position):-
  Position =< 4,
  ringWithoutBallLine(Head, Position).


headStack([Head | _], Head).

headLine([Head | _], 0, Result):-
  headStack(Head, Result).

headLine([_ | Tail], Position, Result):-
  Position > 0,
  NewPosition is Position - 1,
  headLine(Tail, NewPosition, Result).

head([_ | Tail], Position, Result):-
  Position > 4,
  NewPosition is Position - 5,
  head(Tail, NewPosition, Result).

head([Head | _], Position, Result):-
  Position =< 4,
  headLine(Head, Position, Result).

checkWinnerWhite(Board):-
  head(Board, 3, whiteBall),
  head(Board, 4, whiteBall),
  head(Board, 9, whiteBall).


checkWinnerBlack(Board):-
  head(Board, 15, blackBall),
  head(Board, 20, blackBall),
  head(Board, 21, blackBall).

checkAdjacent(OldPosition, NewPosition):- NewPosition is OldPosition + 1, NewPosition // 5 =:= OldPosition // 5.
checkAdjacent(OldPosition, NewPosition):- NewPosition is OldPosition - 1, NewPosition // 5 =:= OldPosition // 5.
checkAdjacent(OldPosition, NewPosition):- NewPosition is OldPosition + 5.
checkAdjacent(OldPosition, NewPosition):- NewPosition is OldPosition - 5.
checkAdjacent(OldPosition, NewPosition):- NewPosition is OldPosition + 4, NewPosition // 5 =:= OldPosition // 5 + 1.
checkAdjacent(OldPosition, NewPosition):- NewPosition is OldPosition - 4, NewPosition // 5 =:= OldPosition // 5 - 1.
checkAdjacent(OldPosition, NewPosition):- NewPosition is OldPosition + 6, NewPosition // 5 =:= OldPosition // 5 + 1.
checkAdjacent(OldPosition, NewPosition):- NewPosition is OldPosition - 6, NewPosition // 5 =:= OldPosition // 5 - 1.

checkBall(Board, Position):-
  head(Board, Position, whiteBall).

checkBall(Board, Position):-
  head(Board, Position, blackBall).

sameLine(OldPosition,NewPosition, _) :-
  OldPositionLine = OldPosition // 5,
  NewPositionLine = NewPosition // 5,
  OldPositionLine =:= NewPositionLine.

sameLine(OldPosition, NewPosition, _):-
  OldPositionColumn = OldPosition mod 5,
  NewPositionColumn = NewPosition mod 5,
  OldPositionColumn =:= NewPositionColumn.

sameLine(OldPosition, NewPosition, N):-
  OldPositionLine = OldPosition // 5,
  NewPositionLine = NewPosition // 5,
  OldPositionColumn = OldPosition mod 5,
  NewPositionColumn = NewPosition mod 5,
  (NewPositionColumn + N =:= OldPositionColumn,
    NewPositionLine + N =:= OldPositionLine;
    (
      NewPositionColumn + N =:= OldPositionColumn,
      NewPositionLine - N =:= OldPositionLine;
      (
        NewPositionColumn - N =:= OldPositionColumn,
        NewPositionLine + N =:= OldPositionLine;
        (
          NewPositionColumn - N =:= OldPositionColumn,
          NewPositionLine - N =:= OldPositionLine;
          fail
        )
      )
    )
  ).

canJump1Ball(Board, OldPosition, NewPosition):-
  sameLine(OldPosition, NewPosition, 2), !,
  (OldPosition > NewPosition ->
    MiddlePosition is integer(NewPosition + ((OldPosition - NewPosition) / 2));
    MiddlePosition is integer(OldPosition + ((NewPosition - OldPosition) / 2))
  ),
  checkAdjacent(OldPosition, MiddlePosition),
  checkAdjacent(MiddlePosition, NewPosition),
  checkBall(Board, MiddlePosition).

canJump2Ball(Board, OldPosition, NewPosition):-
  sameLine(OldPosition, NewPosition, 3), !,
  (OldPosition > NewPosition ->
    Middle2Position is integer(NewPosition + (OldPosition - NewPosition) / 3),
    Middle1Position is integer(NewPosition + (OldPosition - NewPosition) / 3 * 2);
    Middle1Position is integer(OldPosition + (NewPosition - OldPosition) / 3),
    Middle2Position is integer(OldPosition + (NewPosition - OldPosition) / 3 * 2)
  ),
  checkAdjacent(OldPosition, Middle1Position),
  checkAdjacent(Middle1Position, Middle2Position),
  checkAdjacent(Middle2Position, NewPosition),
  checkBall(Board, Middle1Position),
  checkBall(Board, Middle2Position).

canJump3Ball(Board, OldPosition, NewPosition):-
  sameLine(OldPosition, NewPosition, 1), !,
  (OldPosition > NewPosition ->
    Middle3Position is integer(NewPosition + (OldPosition - NewPosition) / 4),
    Middle2Position is integer(NewPosition + (OldPosition - NewPosition) / 4 * 2),
    Middle1Position is integer(NewPosition + (OldPosition - NewPosition) / 4 * 3);
    Middle1Position is integer(OldPosition + (NewPosition - OldPosition) / 4),
    Middle2Position is integer(OldPosition + (NewPosition - OldPosition) / 4 * 2),
    Middle3Position is integer(OldPosition + (NewPosition - OldPosition) / 4 * 3)
  ),
  checkAdjacent(OldPosition, Middle1Position),
  checkAdjacent(Middle1Position, Middle2Position),
  checkAdjacent(Middle2Position,Middle3Position),
  checkAdjacent(Middle3Position, NewPosition),
  checkBall(Board, Middle1Position),
  checkBall(Board, Middle2Position),
  checkBall(Board, Middle3Position).

canMoveBall(Board, OldPosition, NewPosition, Player):-
  ballWithRing(Board, Player, NewPosition),
  (checkAdjacent(OldPosition, NewPosition),
    true;
    (canJump1Ball(Board, OldPosition, NewPosition),
      true;
      (canJump2Ball(Board, OldPosition, NewPosition),
        true;
        canJump3Ball(Board, OldPosition, NewPosition)
      )
    )
  ).
