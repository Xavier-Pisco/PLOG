displayMenu :-
  write('\n\nGRAPES\n\n'),
  write('1 - Run all tests\n'),
  write('2 - Run specific test\n'),
  write('3 - Create random board\n'),
  write('4 - Quit\n').

getMenuInput(Option):-
	write('Choose an option: '),
	read_line([Input]),
	Option is Input - 48.

handleInput(1):-
	testAll.

handleInput(2):-
	write('Choose test number: '),
	read_line(Input),
	numberInput(Input, Number),
	Number > -1,
	boards(Boards),
	length(Boards, N),
	Number < N,
	test(Number).

handleInput(3):-
	write('Choose board size (Recommended max 7): '),
	read_line(Input),
	numberInput(Input, Size),
	generate(Size, Result),
	write('Press enter to see result'), read_line(_), nl, nl,
	displayBoard(Result), !.

handleInput(4).

numberInput(Input, Number):-
	length(Input, 1),
	[Input1] = Input,
	Number is Input1 - 48.

numberInput(Input, Number):-
	length(Input, 2),
	[Input1, Input2] = Input,
	Temp is (Input1 - 48) * 10,
	Number is Temp + Input2 - 48.