-module(doc).
-compile([debug_info, export_all]).
init() ->
    register(bob, spawn(fun bob/0)),
    register(tim, spawn(fun tim/0)),
    io:format("tim, bob, registered~n").

bob() ->
    process_flag(trap_exit, true),
    receive
        {link, To} ->
            link(whereis(To)),
            io:format("Shaking hands~n"),
            bob();
        bang ->
            io:format("Dying~n"),
            exit(bang);
        {'EXIT', Pid, Reason} ->
            io:format("~p has died because ~p~n", [Pid, Reason]),
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
            exit(bang);
        {'EXIT', Pid, Reason} ->
            io:format("~p has died because ~p~n", [Pid, Reason]),
            tim()
        end.
