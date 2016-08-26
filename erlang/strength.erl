-module(strength).
-export([numWords/1]).

splitString(S) -> string:tokens(S, " ").

numTokens([]) -> 0;
numTokens([Head|Tail]) -> 1 + numTokens(Tail).

numWords(Str) -> numTokens(splitString(Str)).
