:- use_module(library(clpfd)).

zero_zeros(N1, N2):-
	Numbers = [CM1, DM1, M1, C1, D1, U1, CM2, DM2, M2, C2, D2, U2],
	domain(Numbers, 0, 9),
	U1 #\= 0, U2 #\= 0,
	Number1 #= CM1 * 100000 + DM1 * 10000 + M1 * 1000 + C1 * 100 + D1 * 10 + U1,
	Number2 #= CM2 * 100000 + DM2 * 10000 + M2 * 1000 + C2 * 100 + D2 * 10 + U2,
	Number1 * Number2 #= 1000000,
	labeling([], Numbers),
	N1 is CM1 * 100000 + DM1 * 10000 + M1 * 1000 + C1 * 100 + D1 * 10 + U1,
	N2 is CM2 * 100000 + DM2 * 10000 + M2 * 1000 + C2 * 100 + D2 * 10 + U2.