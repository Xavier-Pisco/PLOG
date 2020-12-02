equipavencedora(Team, Circuito):-
    vencedor(Pilot, Circuito),
    team(Pilot, Team).

pilot('Lamb').
pilot('Besenyei').
pilot('Chambliss').
pilot('MacLean').
pilot('Mangold').
pilot('Jones').
pilot('Bonhomme').

team('Lamb','Breitling').
team('Besenyei','Red Bull').
team('Chambliss','Red Bull').
team('MacLean','Mediterranean Racing Team').
team('Mangold','Cobra').
team('Jones','Matador').
team('Bonhomme','Matador').

aviao('Lamb','MX2').
aviao('Besenyei','Edge540').
aviao('Chambliss','Edge540').
aviao('MacLean','Edge540').
aviao('Mangold','Edge540').
aviao('Jones','Edge540').
aviao('Bonhomme','Edge540').

circuito('Istanbul').
circuito('Porto').
circuito('Budapest').

vencedor('Jones','Porto').
vencedor('Mangold','Budapest').
vencedor('Mangold','Istanbul').

gates('Istanbul',9).
gates('Budapest',6).
gates('Porto',5).

/**
a) vencedor(Pilot, 'Porto').
b) equipavencedora(Team, 'Porto').
c)  vencedor(Pilot, Circuito1),
    vencedor(Pilot, Circuito2),
    Circuito1 \= Circuito2.
d)  gates(Circuito, Gates),
    Gates > 8.
e)  aviao(Pilot, Aviao),
    Aviao \= 'Edge540'.
*/