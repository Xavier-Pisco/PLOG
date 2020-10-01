parent(aldo, michael).
parent(aldo, lincoln).
parent(christina, michael).
parent(christina, lincoln).
parent(michael, ella).
parent(sara, ella).
parent(lisa, lj).
parent(lincoln, lj).

male(michael).
male(lincoln).
male(aldo).
male(lj).

female(christina).
female(ella).
female(sara).
female(lisa).

mother(Mother, Son):-
    female(Mother),
    parent(Mother,Son).

father(Father, Son):-
    male(Father),
    parent(Father,Son).

/**
a) father(Father, michael).
b) father(aldo, Son).
*/