-module(count).
-export([upto/1]).

upto(X) -> count_to(X, 0).

count_to(X, X) -> io:fwrite("Number ~p~n", [X]);
count_to(X, Y) ->
  io:fwrite("Number ~p~n", [Y]),
  count_to(X, Y+1).
