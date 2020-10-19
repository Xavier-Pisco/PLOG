ordenada([_]).
ordenada([N1, N2|L]):-
    N1 =< N2,
    ordenada([N2|L]).

% RIP ordena
ordena([N],[N]).
