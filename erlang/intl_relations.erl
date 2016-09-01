% after compiling, run like this:
%   > UN = spawn(fun intl_relations:loop/0).
%   > UN ! new.
%   > intl_relations:send_to(translator, "casa").
% or
%   > intl_relations:send_to(translator, "muerte").
% it would be nice to make the receive loop in send_to time out
% in case the translator did not reply at all (because he was dead)

-module(intl_relations).
-export([loop/0, send_to/2]).

loop() ->
    process_flag(trap_exit, true),
    receive
        new ->
            io:format("Creating and monitoring process.~n"),
            register(translator, spawn_link(fun translate:loop/0)),
            loop();
        {'EXIT', From, Reason} ->
            io:format("The translation bureau, ~p has been shuttered: ~p.", [From, Reason]),
            io:format("~nRestarting.~n"),
            self() ! new,
            loop()
    end.

send_to(To, Word) ->
    To ! {self(), Word},
        receive
            Translation -> Translation
        end.
