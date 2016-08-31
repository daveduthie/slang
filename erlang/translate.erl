-module(translate).
-export ([loop/0, translate/2]).
loop() ->
    receive
        {Pid, "casa"} ->
            Pid ! "house",
            loop();
        {Pid, "blanca"} ->
            Pid ! "white",
            loop();
        {Pid, _} ->
            Pid ! "I don't understand.",
            loop()
end.

% Notice that the code inside calls loop() three times, without any returns.
% That’s OK: Erlang is optimized for tail recursion, so there’s very little overhead,
% as long as the last thing in any receive clause is a loop().
% We’re basically defining an empty function and looping forever.

translate(To, Word) ->
    To ! {self(), Word},
    receive
        Translation -> Translation
    end.

% After compiling, run like this:
% > Translator = spawn(fun translate:loop/0).
% > translate:translate(Translator, "casa").