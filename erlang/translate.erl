-module(translate).
-export ([loop/0]).
loop() ->
    receive
        "casa" ->
            io:format("house~n"),
            loop();
        "blanca" ->
            io:format("white~n"),
            loop();
        _ ->
            io:format("I don't understand.~n"),
            loop()
    end.

% Notice that the code inside calls loop() three times, without any returns.
% That’s OK: Erlang is optimized for tail recursion, so there’s very little overhead,
% as long as the last thing in any receive clause is a loop().
% We’re basically defining an empty function and looping forever.