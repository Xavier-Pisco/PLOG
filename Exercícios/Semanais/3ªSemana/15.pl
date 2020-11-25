produto_interno([],[],0).

produto_interno([X | L1], [Y | L2], N):-
  N1 is X * Y,
  produto_interno(L1, L2, N2),
  N is N1 + N2.