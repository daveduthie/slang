-module(anon_func).
-export([map/2]).

map(F, [H|T]) -> [F(H) | map(F, T)];
map(F, [])    -> [].
