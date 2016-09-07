-module(doc).
-compile([debug_info, export_all]).
init() ->
    register(bob, spawn(fun bob/0)),
    register(tim, spawn(fun tim/0)),
    io:format("tim, bob, registered~n"),
    tim ! {link, bob}.

bob() ->
    process_flag(trap_exit, true),
    receive
        {link, To} ->
            link(whereis(To)),
            io:format("Shaking hands~n"),
            bob();
        bang ->
            io:format("Dying~n"),
            exit({bob, bang});
        {'EXIT', Pid, {Doctor, Reason}} ->
            io:format("Doctor ~p ~p has died because ~p~n", [Doctor, Pid, Reason]),
            register(tim, spawn_link(fun tim/0)),
            bob()
        end.

tim() ->
    process_flag(trap_exit, true),
    receive
        {link, To} ->
            link(whereis(To)),
            io:format("Shaking hands~n"),
            tim();
        bang ->
            io:format("Dying~n"),
            exit({tim, bang});
        {'EXIT', Pid, {Doctor, Reason}} ->
            io:format("Doctor ~p ~p has died because ~p~n", [Doctor, Pid, Reason]),
            register(bob, spawn_link(fun bob/0)),
            tim()
        end.
