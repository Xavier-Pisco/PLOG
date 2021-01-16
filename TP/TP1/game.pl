:- [display].
:- [ball].
:- [ring].
:- [rules].
:- [input].
:- [bot].

/** Replaces the Head of the list with Value */
replace(_, _, Value, Value).

removeHead([_ | Tail], Tail).

% move(+GameState, +Move, -NewGameState).
% Neste caso GameState é o [Board, WhiteRings, BlackRings]
% Move é [Player, [ActualRingPosition, NewRingPosition, ActualBallPosition, NewBallPosition]]
move([Board, WhiteRings, _], ['Whites', [ActualRingPosition, NewRingPosition, ActualBallPosition, NewBallPosition]], [NewBoard, NewWhiteRings, _]):-
  moveRing(Board, 'Whites', ActualRingPosition, NewRingPosition, WhiteRings, MiddleBoard, NewWhiteRings),
  moveBall(MiddleBoard, 'Whites', ActualBallPosition, NewBallPosition, NewBoard).


move([Board, _, BlackRings], ['Blacks', [ActualRingPosition, NewRingPosition, ActualBallPosition, NewBallPosition]], [NewBoard, _, NewBlackRings]):-
  moveRing(Board, 'Blacks', ActualRingPosition, NewRingPosition, BlackRings, MiddleBoard, NewBlackRings),
  moveBall(MiddleBoard, 'Blacks', ActualBallPosition, NewBallPosition, NewBoard).

whitePlaying(Board, BlackRings, WhiteRings, NewBoard, NewWhiteRings):-
  repeat,
    inputRing(ActualRingPosition, NewRingPosition),
    inputBall(ActualBallPosition, NewBallPosition),
    Move = [ActualRingPosition, NewRingPosition, ActualBallPosition, NewBallPosition],
    valid_moves([Board, WhiteRings, BlackRings], 'Whites', Moves),
    (member(Move, Moves) ->
      move([Board, WhiteRings, _], ['Whites', Move], [NewBoard, NewWhiteRings, _]);
      write('\nInvalid move\n\n'),
      fail
    ).


blackPlaying(Board, BlackRings, WhiteRings, NewBoard, NewBlackRings):-
  repeat,
    inputRing(ActualRingPosition, NewRingPosition),
    inputBall(ActualBallPosition, NewBallPosition),
    Move = [ActualRingPosition, NewRingPosition, ActualBallPosition, NewBallPosition],
    valid_moves([Board, WhiteRings, BlackRings], 'Blacks', Moves),
    (member(Move, Moves) ->
      move([Board, _, BlackRings], ['Blacks', Move], [NewBoard, _, NewBlackRings]);
      write('\nInvalid move\n\n'),
      fail
    ).


whiteBotPlaying(Board, BlackRings, WhiteRings, Level, NewBoard, NewWhiteRings):-
  choose_move([Board, WhiteRings, BlackRings], 'Whites', Level, Move),
  [ActualRingPosition, NewRingPosition, ActualBallPosition, NewBallPosition] = Move,
  move([Board, WhiteRings, BlackRings], ['Whites', Move], [NewBoard, NewWhiteRings, _]).
  
blackBotPlaying(Board, BlackRings, WhiteRings, Level, NewBoard, NewBlackRings):-
  choose_move([Board, WhiteRings, BlackRings], 'Blacks', Level, Move),
  [ActualRingPosition, NewRingPosition, ActualBallPosition, NewBallPosition] = Move,
  move([Board, WhiteRings, BlackRings], ['Blacks', Move], [NewBoard, _, NewBlackRings]).


gameLoopPVP([Board, BlackRings, WhiteRings]):-
  display_game([Board, BlackRings, WhiteRings], 'Blacks'),
  blackPlaying(Board, BlackRings, WhiteRings, NewBoard, NewBlackRings),
  (game_over([NewBoard, NewBlackRings, WhiteRings], Winner),
    display_winner([NewBoard, NewBlackRings, WhiteRings], Winner);
    display_game([NewBoard, NewBlackRings, WhiteRings], 'Whites'),
    whitePlaying(NewBoard, BlackRings, WhiteRings, FinalBoard, NewWhiteRings),
    (game_over([NewBoard, NewBlackRings, NewWhiteRings], Winner),
      display_winner([NewBoard,NewWhiteRings, NewBlackRings], Winner);
      gameLoopPVP([FinalBoard, NewBlackRings, NewWhiteRings])
    )
  ).

gameLoopPVE([Board, BlackRings, WhiteRings], Level):-
  display_game([Board, BlackRings, WhiteRings], 'Blacks'),
  blackPlaying(Board, BlackRings, WhiteRings, NewBoard, NewBlackRings),
  (game_over([NewBoard, NewBlackRings, WhiteRings], Winner),
    display_winner([NewBoard, NewBlackRings, WhiteRings], Winner);
    display_game([NewBoard, NewBlackRings, WhiteRings], 'Whites'),
    write('Bot turn, Press Enter to continue.\n'),
    read_line(_),
    whiteBotPlaying(NewBoard, BlackRings, WhiteRings, Level, FinalBoard, NewWhiteRings),
    (game_over([NewBoard,NewBlackRings,NewWhiteRings],Winner),
      display_winner([NewBoard,NewWhiteRings, NewBlackRings], Winner);
      gameLoopPVE([FinalBoard, NewBlackRings, NewWhiteRings], Level)
    )
  ).

gameLoopEVE([Board, BlackRings, WhiteRings]):-
  display_game([Board, BlackRings, WhiteRings], 'Blacks'),
  write('Bot turn, Press Enter to continue.\n'),
  read_line(_),
  blackBotPlaying(Board, BlackRings, WhiteRings, 'Hard', NewBoard, NewBlackRings),
  (game_over([NewBoard, NewBlackRings, WhiteRings],Winner),
    display_winner([NewBoard, NewBlackRings, WhiteRings], Winner);
    display_game([NewBoard, NewBlackRings, WhiteRings], 'Whites'),
    write('Bot turn, Press Enter to continue.\n'),
    read_line(_),
    whiteBotPlaying(NewBoard, BlackRings, WhiteRings, 'Easy', FinalBoard, NewWhiteRings),
    (game_over([NewBoard, NewBlackRings, NewWhiteRings], Winner),
      display_winner([NewBoard,NewWhiteRings,NewBlackRings], Winner);
      gameLoopEVE([FinalBoard, NewBlackRings, NewWhiteRings])
    )
  ).

% game_over(+GameState, -Winner).
game_over([Board, WhiteRings, BlackRings], 'Blacks'):-
  checkWinnerBlack(Board).

game_over([Board, WhiteRings, BlackRings], 'Whites'):-
  checkWinnerWhite(Board).

game_over([Board, WhiteRings, BlackRings], 'Blacks'):-
  valid_moves([Board, WhiteRings, BlackRings], 'Blacks', []).


game_over([Board, WhiteRings, BlackRings], 'Whites'):-
  valid_moves([Board, WhiteRings, BlackRings], 'Whites', []).

/*Função que chama initBoard
e posteriormente printBoard, para dar display do tabuleiro*/
play :-
  displayMenu,
  inputMenu(Mode),
  nl,
  (Mode == 1 ->
    initial(Board, BlackRings, WhiteRings),
    gameLoopPVP([Board, BlackRings, WhiteRings]);
    (Mode == 2 ->
      initial(Board,BlackRings,WhiteRings),
      gameLoopPVE([Board,BlackRings,WhiteRings], 'Easy');
      (Mode == 3 ->
        initial(Board, BlackRings, WhiteRings),
        gameLoopPVE([Board,BlackRings,WhiteRings], 'Hard');
        (Mode == 4 ->
          write('Here\n'),
          initial(Board, BlackRings, WhiteRings),
          gameLoopEVE([Board,BlackRings,WhiteRings]);
          write('Invalid Number\n')
        )
      )
    )
  ).

