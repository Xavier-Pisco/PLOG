passaro('Tweety').
peixe('Goldie').
minhoca('Molie').
gosta(X,Y):-
    passaro(X),
    minhoca(Y).
gosta(X,Y):-
    gato(X),
    peixe(Y).
gosta(X,Y):-
    gato(X),
    passaro(Y).
gosta(X,Y):-
    amigo(X,Y).
come(X,Y):-
    gosta(X,Y).
gato('Silvester').
amigo(eu,'Silverster').

/**
a)  come('Silvester', X).
b)  O gato pode comer o 'eu' porque gosta dele.
*/
