/*
Função que inicia o tabuleiro, com os símbolos respetivos
*/
initial([
  [[empty], [empty], [empty], [blackBall, blackRing, empty], [blackBall, blackRing, empty]],
  [[empty], [empty], [empty], [empty], [blackBall, blackRing, empty]],
  [[empty], [empty], [empty], [empty], [empty]],
  [[whiteBall, whiteRing, empty], [empty], [empty], [empty], [empty]],
  [[whiteBall, whiteRing, empty], [whiteBall, whiteRing, empty], [empty], [empty], [empty]]
], 5, 5).

mid([
  [[empty], [empty], [blackRing, empty], [empty], [whiteBall, whiteRing, empty]],
	[[empty], [empty], [whiteBall, whiteRing, empty], [empty], [whiteBall, whiteRing, empty]],
	[[empty], [empty], [blackBall, blackRing, empty], [empty], [blackRing, empty]],
	[[blackBall, blackRing, empty], [empty], [blackRing, empty], [empty], [empty]],
	[[blackBall,blackRing, empty], [empty], [empty], [empty], [empty]]
], 4, 3).

final([
	[[empty], [empty],[empty], [whiteBall,whiteRing, blackRing, empty], [whiteBall, whiteRing, empty]],
	[[empty], [whiteRing], [blackRing], [empty], [whiteBall, whiteRing, empty]],
	[[blackBall, blackRing, empty], [blackRing, whiteRing, empty], [empty], [empty], [blackRing, empty]],
	[[blackBall, blackRing, whiteRing, empty], [empty], [empty], [empty], [empty]],
	[[blackRing, whiteRing, empty], [blackBall, blackRing, empty], [empty], [empty], [empty]]
], 0, 1).

/*Atribuição dos símbolos aos carateres correspondentes*/
symbol(empty, ' ').
symbol(whiteBall, 'W').
symbol(blackBall, 'B').
symbol(blackRing, 'b').
symbol(whiteRing, 'w').

/*
* display_line(Lista) dá print de uma linha do tablueiro
* Para cada linha escreve os valores correpondentes separados por '  |  '
*/
display_stack([], 0).

display_stack([], N):-
  N > 0,
  N1 is N - 1,
  write(' '),
  display_stack([], N1).

display_stack([Head | Tail], N):-
  N > 0,
  N1 is N - 1,
  symbol(Head, S),
  write(S),
  display_stack(Tail, N1).

display_line([]).

display_line([Head | Tail]):-
  display_stack(Head, 12),
  write('|'),
  display_line(Tail).

/*
* Mostra o tabuleiro no ecrã e nome de colunas e linhas
* Como argumento recebe um tabuleiro de tamanho 5 * 5
*/
display_game([[A, B, C, D, E], BlackRings, WhiteRings], Player):-
  write('\n\n\n\n\n\n\n'),
  write('  |     1      |     2      |     3      |     4      |     5      |\n'),
  write('--------------------------------------------------------------------\n'),
  write('A |'),
  display_line(A),
  write('\n--------------------------------------------------------------------\n'),
  write('B |'),
  display_line(B),
  write('\n--------------------------------------------------------------------\n'),
  write('C |'),
  display_line(C),
  write('\n--------------------------------------------------------------------\n'),
  write('D |'),
  display_line(D),
  write('\n--------------------------------------------------------------------\n'),
  write('E |'),
  display_line(E),
  write('\n--------------------------------------------------------------------\n'),
  write('Blacks has '),
  write(BlackRings),
  write(' rings left.\nWhites has '),
  write(WhiteRings),
  write(' rings left.\n\n'),
  write(Player),
  write(' turn.\n\n\n').

displayMenu :-
  write('MITSUDOMOE\n\n'),
  write('1 - Player vs Player\n'),
  write('2 - Player vs CPU(easy)\n'),
  write('3 - Player vs CPU(hard)\n'),
  write('4 - CPU vs CPU\n\n').

display_winner([[A, B, C, D, E], BlackRings, WhiteRings], Player):-
  write('\n\n\n\n\n\n\n'),
  write('  |     1      |     2      |     3      |     4      |     5      |\n'),
  write('--------------------------------------------------------------------\n'),
  write('A |'),
  display_line(A),
  write('\n--------------------------------------------------------------------\n'),
  write('B |'),
  display_line(B),
  write('\n--------------------------------------------------------------------\n'),
  write('C |'),
  display_line(C),
  write('\n--------------------------------------------------------------------\n'),
  write('D |'),
  display_line(D),
  write('\n--------------------------------------------------------------------\n'),
  write('E |'),
  display_line(E),
  write('\n--------------------------------------------------------------------\n'),
  write('\n\n'),write(Player),write(' won\n').