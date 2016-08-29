-module(hash).
-export([get_val/2]).

get_val(Key, Hash) -> [V || {K, V} <- Hash, K =:= Key].
