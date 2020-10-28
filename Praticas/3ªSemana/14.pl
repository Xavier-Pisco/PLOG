divisivel(N, X):-
  0 is mod(N,X).

primo(_, 1).
primo(N, X):-
  \+divisivel(N, X),
  X1 is X - 1,
  primo(N, X1).

primo(1).
primo(N):-
  N1 is N - 1,
  primo(N, N1).

lista_primos(1, []).
lista_primos(0, []).
lista_primos(N, [N | L]):-
  N > 1,
  primo(N),
  N1 is N - 1,
  lista_primos(N1, L).

lista_primos(N, L):-
  N > 1,
  \+primo(N),
  N1 is N - 1,
  lista_primos(N1, L).