-module(tic).
-export ([result/1, boardWin/0, boardDraw/0, boardUnfinished/0]).

result(Board) -> case winner(Board) of
    [true,false] -> "Win for X";
    [false,true] -> "Win for O";
    _            -> case lists:any(fun(E) -> E =:= e end, Board) of
                        true -> "Unfinished business";
                        false -> "Draw"
                    end
end.

winner(Board) -> [winner(Player, Board) || Player <- [x,o]].
winner(P, Board) -> lists:any(fun(Tup) ->
    Tup =:= [P, P, P] end, combos(Board)).

combos(B) ->
    [select({X,Y,Z}, B) || {X,Y,Z} <- winning_pos()].

select({X,Y,Z}, List) ->
    [lists:nth(X, List), lists:nth(Y, List), lists:nth(Z, List)].

winning_pos()       -> [{1,2,3}, {4,5,6}, {7,8,9},
                        {1,4,7}, {2,5,8}, {3,6,9},
                        {1,5,9}, {3,5,7}].

% for testing: sample boards for Win, Draw, and Unfinished cases
boardWin()          -> [x,o,o,
                        x,o,x,
                        x,x,o].
boardDraw()         -> [x,o,x,
                        o,x,x,
                        o,x,o].
boardUnfinished()   -> [x,o,e,
                        x,o,x,
                        e,x,o].