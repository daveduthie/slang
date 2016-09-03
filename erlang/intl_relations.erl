% after compiling, run like this:
%   > UN = spawn(fun intl_relations:loop/0).
%   > UN ! newAgency.
%   > UN ! {translate, "casa"}.
%   > UN ! {translate, "muerte"}. % will kill the translator!
%
% it would be nice to make the receive loop in translate() time out
% in case the translator did not reply at all (because he was dead)

-module(intl_relations).
-export([loop/0]).

loop() ->
    process_flag(trap_exit, true),
    receive
        {translate, Word} ->
            translate(Word),
            loop();
        newAgency ->
            io:format("Creating and monitoring process.~n"),
            register(translator, spawn_link(fun translate:loop/0)),
            loop();
        {'EXIT', From, Reason} ->
            io:format("The translation bureau, ~p has been shuttered: ~p.", [From, Reason]),
            io:format("~nRestarting.~n"),
            self() ! new,
            loop()
    end.

translate(Word) ->
    translator ! {self(), Word},
        receive
            Translation ->
                io:format("Translazione: ~p~n", [Translation])
        end.
