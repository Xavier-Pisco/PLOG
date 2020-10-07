e_primo(2).
e_primo(3).
e_primo(X):-
    X > 3,
    integer(X),
    X mod 2 =\= 0,
    \+extra(X,3).
extra(X,Y):-
    X mod Y =:= 0.
extra(X,Y):-
    Y * Y < X,
    Y1 is Y + 2,
    extra(X,Y1).

/**
Não consegui fazer sem ser com base na solução
*/