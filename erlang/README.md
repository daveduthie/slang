# Day 1

What are bitmaps? Behold: [Bitmap - Wikipedia, the free encyclopedia](https://en.wikipedia.org/wiki/Bitmap).

## Homework

Find:

- The Erlang language’s official site
    - [erlang.org](http://www.erlang.org)
- Official documentation for Erlang’s function library
    - [User's Guide](http://erlang.org/doc/reference_manual/users_guide.html)
    - [Documentation](http://erlang.org/doc/search/)
- The documentation for Erlang’s OTP library
    - [Introduction](http://erlang.org/doc/design_principles/des_princ.html)
    - [Fred Hebert's Intro to OTP](http://learnyousomeerlang.com/what-is-otp)

Do:

- Write a function that uses recursion to return the number of words in a string
- Write a function that uses recursion to count to ten
- Write a function that uses matching to selectively print “success” or “error: message” given input of the form `{error, Message}` or `success`

### Write a function that uses recursion to return the number of words in a string

First I split the string into a list of words (tokens). Next, I define a prolog-y recursive function to count the number of tokens. Finally, I export a function to tie these first two together.

```erlang
-module(strength).
-export([numWords/1]).

splitString(S) -> string:tokens(S, " ").

numTokens([]) -> 0;
numTokens([Head|Tail]) -> 1 + numTokens(Tail).

numWords(Str) -> numTokens(splitString(Str)).
```

Run it like this:

```erl
1> c(strength).
strength.erl:7: Warning: variable 'Head' is unused
{ok,strength}
2> MyString = "I am a string. This is the law of the jungle.".
"I am a string. This is the law of the jungle."
3> strength:numWords(MyString).
11
```

### Write a function that uses recursion to count to ten

```erlang
-module(count).
-export([upto/1]).

upto(X) -> count_to(X, 0).

count_to(X, X) -> io:fwrite("Number ~p~n", [X]);
count_to(X, Y) ->
  io:fwrite("Number ~p~n", [Y]),
  count_to(X, Y+1).
```

Output:

```erl
Eshell V8.0.2  (abort with ^G)
1> c(count).
{ok,count}
2> count:upto(5).
Number 0
Number 1
Number 2
Number 3
Number 4
Number 5
ok
```

### Write a function that uses matching to selectively print “success” or “error: message” given input of the form `{error, Message}` or `success`

```erlang
-module(errata).
-export([check/1]).

check(success) -> io:fwrite("success~n");
check({error, Message}) -> io:fwrite("error: ~p~n", [Message]).
```

Output:

```erl
Eshell V8.0.2  (abort with ^G)
1> c(errata).
{ok,errata}
2> errata:check(success).
success
ok
4> errata:check({error, """It's broken, mate."""}).
error: "It's broken, mate."
ok
5> errata:check(yo).
** exception error: no function clause matching errata:check(yo) (errata.erl, line 4)
```

# Day 2

## Anonymous functions

Anonymous functions use the `fun()` and `end` keywords.
Example: `Map = fun(F, [H|T]) -> [F(H) | Map(F, T)] end.`

## Fold left

Fold left works like this: `lists:foldl(Adder, InitialSum, Numbers).`

## List comprehensions

Here's a list: `Fibs = [1,1,2,3,5].`.

These functions are equivalent:
`lists:map(fun(X) -> X * 2 end, Fibs).` and
`[X * 2 || X <- Fibs].`.

The second method is appealing because it resembles set notation and because it allows us to build for complex functions more easily. Behold the power:

```erl
19> Cart =[{pencil, 4, 0.25}, {pen, 1, 1.20}, {paper, 2, 0.20}].
[{pencil,4,0.25},{pen,1,1.2},{paper,2,0.2}]
20> WithTax = [{Product, Quantity, Price, Price * Quantity * 0.08} || {Product, Quantity, Price} <- Cart].
[{pencil,4,0.25,0.08},{pen,1,1.2,0.096},{paper,2,0.2,0.032}]
```

## Homework

Do:

- Consider a list of keyword-value tuples, such as `[{erlang, "a functional language"}, {ruby, "an OO language"}].` Write a function that accepts the list and a keyword and returns the associated value for the keyword
- Consider a shopping list that looks like `[{item, quantity, price}, ...]`. Write a list comprehension that builds a list of items of the form `[{item, total_price}, ...]`, where `total_price` is quantity times price
- **Bonus:** write a tic-tac-toe tester that accepts a board as a list of length 9 and tests if there's a winner, if it's a draw, or if the game is unfinished

### Home made hash

Amazingly, this can be implemented in one line!

```erlang
-module(hash).
-export([get_val/2]).

get_val(Key, Hash) -> [V || {K, V} <- Hash, K =:= Key].
```

```erl
60> Hash.
[{ruby,"An OO dream"},
 {io,"An interesting but frustrating maze"},
 {prolog,"My true love"}]
61> hash:get_val(prolog, Hash).
["My true love"]
```

### Shopping list

```erlang
-module(shopping).
-export([totalPerItem/1]).

totalPerItem(Cart) -> [{Item, Quantity * Price} || {Item, Quantity, Price} <- Cart].
```

### Tic-Tac-Toe tester

[![asciicast](https://asciinema.org/a/84417.png)](https://asciinema.org/a/84417)

There's quite a bit of code:

```erlang
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
```
