:- use_module(library(clpfd)).

compras(['Adams'-CA, 'Baker'-CB, 'Catt'-CC, 'Dodge'-CD, 'Ennis'-CE, 'Fisk'-CF]):-
	Comprou = [CA, CB, CC, CD, CE, CF],
	Andares = [AA, AB, AC, AD, AE, AF],
	domain(Comprou, 0, 5),
	domain(Andares, 0, 6),
	all_distinct(Comprou),
	AA #= 0,
	CA #= 0,
	AC #= 2,
	AF #= 6,
	CB #\= 2,
	CB #\= 3,
	%Ennis foi a sexta pessoa => AE = 4 \/ AE = 5
	AE #= 4 #\/ AE #= 5,
	%Quem comprou a gravata(3) saiu no 2º andar para além da Catt
	(CA #= 3 #/\ AA #= 2) #\/ (CB #= 3 #/\ AB #= 2) #\/ (CD #= 3 #/\ AD #= 2) #\/ (CE #= 3 #/\ AE #= 2) #\/ (CF #= 3 #/\ AF #= 2),
	%Quem saiu no 2º andar comprou a bolsa(2)
	(CA #= 2 #/\ AA #= 2) #\/ (CB #= 2 #/\ AB #= 2) #\/ (CC #= 2 #/\ AC #= 2) #\/ (CD #= 2 #/\ AD #= 2) #\/ (CE #= 2 #/\ AE #= 2) #\/ (CF #= 2 #/\ AF #= 2),
	%Quem saiu no 3º andar comprou vestido(1)
	(CA #= 1 #/\ AA #= 3) #\/ (CB #= 1 #/\ AB #= 3) #\/ (CC #= 1 #/\ AC #= 3) #\/ (CD #= 1 #/\ AD #= 3) #\/ (CE #= 1 #/\ AE #= 3) #\/ (CF #= 1 #/\ AF #= 3),
	%Quem comprou o candeeiro(5) saiu no 5º andar
	(CA #= 5 #/\ AA #= 5) #\/ (CB #= 5 #/\ AB #= 5) #\/ (CC #= 5 #/\ AC #= 5) #\/ (CD #= 5 #/\ AD #= 5) #\/ (CE #= 5 #/\ AE #= 5) #\/ (CF #= 5 #/\ AF #= 5),
	labeling([], Comprou).

