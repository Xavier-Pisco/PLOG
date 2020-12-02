runlenght([],[]).

runlenght([X|Tail], Result):-
  runlenght([X|Tail], Result, []).

runlenght([], L, L).

runlenght([H|Tail], Result, Temp):-
  contar([H|Tail], H, N),
  eliminate([H|Tail], H, Clean),
  append(Temp, [[H, N]], Temp1),
  runlenght(Clean, Result, Temp1).

contar([],_,0).
contar([X|_], Y, 0):-
  X \= Y.
contar([X|L], X, N):-
  contar(L, X, N1),
  N is N1 + 1.

eliminate([], _, []).
eliminate([X|L], Y, [X|L]):-
  X \= Y.
eliminate([X|L], X, L1):-
  eliminate(L, X, L1).