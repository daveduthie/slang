-module(errata).
-export([check/1]).

check(success) -> fwrite("success~n");
check({Error, Message}) -> fwrite("error: ~p~n", [Message])