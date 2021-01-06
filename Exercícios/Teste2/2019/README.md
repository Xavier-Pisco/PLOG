# Teste 2 - 2018/19

[teste](https://drive.google.com/drive/folders/1MngkqQ8Iqumq8xZteWe61fOYSOQFKg4N)

## Pergunta 1

| |1|2| |K|
|-|-|-|-|-|
|1| | | | |
|2| | | | |
| | | | | |
|N| | | | |

[1, 1], [1, 2], ..., [1, K], [2, 1], ..., [N, K].

Assim vão existir N * K variáveis.

As variáveis do domínio são N e K logo tamanho 2.

Espaço de pesquisa: 2<sup>NK</sup>

## Pergunta 2

1, 2, ..., N

Variáveis de domínio = K.

Domínio = N.

Espaço de procura = K<sup>N</sup>

## Pergunta 3

```
pres(N, K, Vars):-
	length(Vars, N),
	domain(Vars, 1, K),
	%
	indices(1, Vars),
	%
	labeling([], Vars).

indices(I, [V | Vs]):-
	V mod 2 #\= I mod 2,
	I1 is I + 1,
	indices(I1, Vs).

indices(_, []).
```
Este programa cria uma lista com o tamanho igual ao número de presetes e com valores que variam entre 1 e o número de pessoas. Assim, vai criar uma lista com o número de cada presente na posição de cada pessoas. Por exemplo a lista [1,3] significa que a pessoa 1 recebeu o presente 1 e a pessoa 3 recebeu o presente 2.

Com a restrição no predicado indices(I, V), o programa garante que a uma presente par corresponde uma pessoa ímpar e vice-versa.

Concluindo, o programa permite obter uma lista em que os elementos aparecem alternadamente pares e ímpares.

## Pergunta 4

A restrição faz com que um número determinado número só possa ser par ou que o número só possa ser ímpar.
- a: Falso, provoca alterações.
- b: Falso, se o K for 3 domínio nos presentes ímpares vai ser 1 V 3, ou seja, vai manter os limites superior e inferior
- c: Falso???
- d: Falso, todas as variáveis passam a ter um domínio com aproximadamente metade dos valores originais.

## Pergunta 5

Não percebi muito bem o exercício mas fiz isto
```
constroi_bins(_, [], []).
constroi_bins(I, [VH | VT], [LBinH | LBinT]):-
	I #= VH,
	LBinH #= VH,
	constroi_bins(I, VT, LBinT).
constroi_bins(I, [VH | VT], LBin):-
	VH #\= I,
	constroi_bins(I, VT, LBin).
```

## Pergunta 6

O comprimento da lista Vars vai ser o comprimento da lista de objetos, uma vez que cada variável da estante representa a posição na estante de um objeto.

O domínio atribuídos às variàveis em Vars será o número de partições do armário em altura vezes o número de partições em comprimento.

Assim, a lista Vars vai ser um lista com comprimento igual à lista de objetos em que cada valor da lista representa o compartimento no armário, começando a contar da esquerda para a direita e de cima para baixo.

[código](resolucao.pl#36)

## Pergunta 7