-module(hash).
-export([get_val/2]).

get_val(Key, Hash) -> lists:last([V || {K, V} <- Hash, K =:= Key]).
