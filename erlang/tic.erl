-module(tic).
-export ([result/1]).
-export ([boardDraw/0]).
-export ([boardWin/0]).

result(Board) ->
  case check(Board) of
    [true,false] -> "Win for X";
    [false,true] -> "Win for O";
    _            -> "No winner"
  end.

check(Board) -> [winner(Player, Board) || Player <- [x,o]].

winner(Player, Board) ->
  lists:any(fun(Tup) ->
    Tup =:= [Player, Player, Player] end,
    combos(Board)).

combos(B) -> [fromList({X,Y,Z}, B) || {X,Y,Z} <- wins()].

fromList({X,Y,Z}, List) -> [lists:nth(X, List),
                            lists:nth(Y, List),
                            lists:nth(Z, List)].

wins() -> [{1,2,3}, {4,5,6}, {7,8,9},
           {1,4,7}, {2,5,8}, {3,6,9},
           {1,5,9}, {3,5,7}].

boardDraw() -> [x,o,e,
                x,o,x,
                e,x,o].

boardWin()  -> [x,o,o,
                x,o,x,
                x,x,o].
