-module(strength).
-export([numWords/1]).

numWords("") -> 0;
numWords(String) -> string:words(String).
