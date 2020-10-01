homem('João').
mulher('Maria').
mulher('Ana').
mora_em('João',casa).
mora_em('Maria',apartamento).
mora_em('Ana',apartamento).
gosta_de('João','cão').
gosta_de('João',xadrez).
gosta_de('Maria','cão').
gosta_de('Maria',gato).
gosta_de('Maria','natação').
gosta_de('Maria',damas).
gosta_de('Ana','cão').
gosta_de('Ana',tigre).
gosta_de('Ana','tenis').
gosta_de('Ana','natação').
animal('cão').
animal('gato').
animal('tigre').
desporto('ténis').
desporto('natação').
desporto('natação').
jogo(xadrez).
jogo(damas).

gosta_de_animal(Pessoa):-
    gosta_de(Pessoa,Animal),
    animal(Animal).

gosta_de_desporto(Pessoa):-
    gosta_de(Pessoa,Desporto),
    desporto(Desporto).


gosta_de_jogos(Pessoa):-
    gosta_de(Pessoa,Jogo),
    jogo(Jogo).


/**
a)  mora_em(Pessoa, apartamento),
    gosta_de_animal(Pessoa).
b)  mora_em('João', casa),
    mora_em('Maria',casa),
    gosta_de_desporto('João'),
    gosta_de_desporto('Maria').
c)  gosta_de_jogos(Pessoa),
    gosta_de_desporto(Pessoa).
d)  mulher(Pessoa),
    gosta_de(Pessoa,'tenis'),
    gosta_de(Pessoa,tigre).
*/
