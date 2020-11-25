livro('Os Maias').
autor('Eça de Queiroz').
nacionalidade('Eça de Queiroz', português).
nacionalidade('Eça de Queiroz', inglês).
tipo('Os Maias', romance).
tipo('Os Maias', 'ficcao').
escreveu('Eça de Queiroz', 'Os Maias').

/**
a)  escreveu(Autor, 'Os Maias').
b)  tipo(Livro, romance),
    escreveu(Autor, Livro).
c)  tipo(Livro1, 'ficcao'),
    tipo(Livro2, Tipo),
    escreveu(Autor, Livro1),
    escreveu(Autor, Livro2),
    Tipo \= 'ficcao'.
*/
