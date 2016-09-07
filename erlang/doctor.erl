-module(doctor).
-compile([debug_info, export_all]).
init() ->
    register(bob, spawn(fun bob/0)),
    register(tim, spawn(fun tim/0)),
    io:format("tim, bob, registered~n"),
    tim ! {link, bob}.

bob() ->
    process_flag(trap_exit, true),
    receive
        %% inter-doctor communication
        {link, To} ->
            link(whereis(To)),
            io:format("Shaking hands~n"),
            bob();
        {'EXIT', Pid, {Doctor, Reason}} ->
            io:format("Doctor ~p ~p has died because ~p~n", [Doctor, Pid, Reason]),
            register(tim, spawn_link(fun tim/0)),
            io:format("Phew... I managed to spawn a new ~p~n", [Doctor]),
            bob();
        %% gun laws
        dealGun ->
            io:format("Looking shady...~nDealing gun...~n"),
            register(revolver, spawn_link(fun roulette:loop/0)),
            bob();
        {'EXIT', From, Reason} ->
            io:format("The shooter ~p died with reason ~p.~n", [From, Reason]),
            io:format("Restarting. ~n"),
            self() ! dealGun,
            bob();
        %% how to die
        Illness ->
            io:format("Dying~n"),
            exit({bob, Illness})
        end.

tim() ->
    process_flag(trap_exit, true),
    receive
        %% inter-doctor communication
        {link, To} ->
            link(whereis(To)),
            io:format("Shaking hands~n"),
            tim();
        {'EXIT', Pid, {Doctor, Reason}} ->
            io:format("Doctor ~p ~p has died because ~p~n", [Doctor, Pid, Reason]),
            register(bob, spawn_link(fun bob/0)),
            io:format("Phew... I managed to spawn a new ~p~n", [Doctor]),
            tim();
        %% gun laws
        dealGun ->
            io:format("I'm outraged! I'm a doctor, not a gangster.~n"),
            tim();
        Illness ->
            io:format("Dying~n"),
            exit({tim, Illness})
        end.
