% sudoku solver in prolog, yo
:- use_module(library(clpfd)).

:- begin_tests(test).

test(sudoku) :-
	sudoku([
    _,_,_,3,4,_,_,_,7,
    _,_,5,_,2,_,_,_,_,
    3,_,2,1,7,_,8,9,_,
    _,6,9,8,_,_,_,7,5,
    _,8,7,_,_,_,3,6,_,
    2,5,_,_,_,4,9,8,_,
    _,3,4,_,8,6,1,_,9,
    _,_,_,_,3,_,6,_,_,
    9,_,_,_,5,1,_,_,_],
    Solution),
  assertion(Solution == [
    6,9,1,3,4,8,5,2,7,
    8,7,5,6,2,9,4,1,3,
    3,4,2,1,7,5,8,9,6,
    4,6,9,8,1,3,2,7,5,
    1,8,7,5,9,2,3,6,4,
    2,5,3,7,6,4,9,8,1,
    7,3,4,2,8,6,1,5,9,
    5,1,8,9,3,7,6,4,2,
    9,2,6,4,5,1,7,3,8]).

:- end_tests(test).

valid([]).
valid([Head|Tail]) :- all_distinct(Head), valid(Tail).

printbyrow([A,B,C,D,E,F,G,H,I|Tail]) :-
  format('~w ~w ~w ~w ~w ~w ~w ~w ~w ~n', [A,B,C,D,E,F,G,H,I]), printbyrow(Tail).
printbyrow([]) :- !.

sudoku(Puzzle, Solution) :-
  Solution = Puzzle,
  Puzzle = [
    S11, S12, S13, S14, S15, S16, S17, S18, S19,
    S21, S22, S23, S24, S25, S26, S27, S28, S29,
    S31, S32, S33, S34, S35, S36, S37, S38, S39,
    S41, S42, S43, S44, S45, S46, S47, S48, S49,
    S51, S52, S53, S54, S55, S56, S57, S58, S59,
    S61, S62, S63, S64, S65, S66, S67, S68, S69,
    S71, S72, S73, S74, S75, S76, S77, S78, S79,
    S81, S82, S83, S84, S85, S86, S87, S88, S89,
    S91, S92, S93, S94, S95, S96, S97, S98, S99],

  global_cardinality(Puzzle, [1-9, 2-9, 3-9, 4-9, 5-9, 6-9, 7-9, 8-9, 9-9]),

	Row1 = [S11, S12, S13, S14, S15, S16, S17, S18, S19],
	Row2 = [S21, S22, S23, S24, S25, S26, S27, S28, S29],
	Row3 = [S31, S32, S33, S34, S35, S36, S37, S38, S39],
	Row4 = [S41, S42, S43, S44, S45, S46, S47, S48, S49],
	Row5 = [S51, S52, S53, S54, S55, S56, S57, S58, S59],
	Row6 = [S61, S62, S63, S64, S65, S66, S67, S68, S69],
	Row7 = [S71, S72, S73, S74, S75, S76, S77, S78, S79],
	Row8 = [S81, S82, S83, S84, S85, S86, S87, S88, S89],
	Row9 = [S91, S92, S93, S94, S95, S96, S97, S98, S99],


	Col1 = [S11, S21, S31, S41, S51, S61, S71, S81, S91],
	Col2 = [S12, S22, S32, S42, S52, S62, S72, S82, S92],
	Col3 = [S13, S23, S33, S43, S53, S63, S73, S83, S93],
	Col4 = [S14, S24, S34, S44, S54, S64, S74, S84, S94],
	Col5 = [S15, S25, S35, S45, S55, S65, S75, S85, S95],
	Col6 = [S16, S26, S36, S46, S56, S66, S76, S86, S96],
	Col7 = [S17, S27, S37, S47, S57, S67, S77, S87, S97],
	Col8 = [S18, S28, S38, S48, S58, S68, S78, S88, S98],
	Col9 = [S19, S29, S39, S49, S59, S69, S79, S89, S99],

	Sqr1 = [S11, S12, S13, S21, S22, S23, S31, S32, S33],
	Sqr2 = [S41, S42, S43, S51, S52, S53, S61, S62, S63],
	Sqr3 = [S71, S72, S73, S81, S82, S83, S91, S92, S93],
	Sqr4 = [S14, S15, S16, S24, S25, S26, S34, S35, S36],
	Sqr5 = [S44, S45, S46, S54, S55, S56, S64, S65, S66],
	Sqr6 = [S74, S75, S76, S84, S85, S86, S94, S95, S96],
	Sqr7 = [S17, S18, S19, S27, S28, S29, S37, S38, S39],
	Sqr8 = [S47, S48, S49, S57, S58, S59, S67, S68, S69],
	Sqr9 = [S77, S78, S79, S87, S88, S89, S97, S98, S99],

	valid([
    Row1, Row2, Row3, Row4, Row5, Row6, Row7, Row8, Row9,
    Col1, Col2, Col3, Col4, Col5, Col6, Col7, Col8, Col9,
    Sqr1, Sqr2, Sqr3, Sqr4, Sqr5, Sqr6, Sqr7, Sqr8, Sqr9]),

  format('~n', []),
  printbyrow(Solution).
