% zu ist prolog
my_reverse([], []).
my_reverse([Head|Tail1], [Tail2|Head]) :- my_reverse(Tail1, Tail2).

my_smallest(Result, [Result]).
my_smallest(Result, [H1 | [H2|Tail] ]) :- H1 @=< H2, my_smallest(Result, [H1|Tail]).
my_smallest(Result, [H1 | [H2|Tail] ]) :- H2 @=< H1, my_smallest(Result, [H2|Tail]).

my_remainder(Result, Drop, [H|Tail]) :- Drop \== H, my_remainder(InnerResult, Drop, Tail), Result = [H|InnerResult].
my_remainder(Result, Drop, [H|Tail]) :- Drop == H, Result = Tail.

my_sort([Result], [Result]).
my_sort(Result, List) :- my_smallest(Small, List), my_remainder(Rem, Small, List), my_sort(SortedTail, Rem), Result = [Small|SortedTail].
