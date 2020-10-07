factorial(0,1).
factorial(0,1.0).
factorial(1,1.0).
factorial(1,1).
factorial(N, Valor):-
    N > 1,
    N1 is N - 1,
    Valor1 is Valor / N,
    factorial(N1, Valor1).

/**
factorial(1,1).
factorial(5,120).
*/

fibonacci(0,1).
fibonacci(0,1.0).
fibonacci(1,1.0).
fibonacci(1,1).
fibonacci(N, Valor):-
    N > 1,
    N1 is N - 1,
    N2 is N - 2,
    fibonacci(N1, Valor1),
    fibonacci(N2, Valor2),
    Valor is Valor1+Valor2.

/**
fibonacci(1,1).
fibonacci(6,13).
*/