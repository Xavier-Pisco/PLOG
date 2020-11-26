:- [database].

whatDoesItDo(X):-
	player(Y, X, Z), !,
	\+ (played(X, G, L, M),
			game(G, N, W),
			W > Z).

/*
Para um determinado jogador X verifica se todos os jogos que
este jogador joga são de idade mínima menor que a sua idade

O nome do predicado poderia ser playingAdequateGames(Player),
as variáveis Y, L, M e N poderia ser trocadas por _ pois não
são necessárias para a execução do predicado. A variável Z
seria trocada por PlayerAge, G por Game e W por MinimumAge.

Neste caso o cut é um cut vermelho pois serve para evitar que,
caso o jogador tenha jogado algum jogo que não é adequado para
a sua idade, o prolog não vai tentar encontrar um outro jogador
com o mesmo nome.
*/