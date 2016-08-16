%% ---
%%  Excerpted from "Seven Languages in Seven Weeks",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/btlang for more book information.
%%---
concatenate([], List, List).
concatenate([Head|Tail1], List, [Head|Tail2]) :- 
  concatenate(Tail1, List, Tail2). 

/* The concatenation (let's call it C) of two lists (A and B) is the same if the head of 'A' is the same as the head of 'C' and the tail of 'C' is the same as the concatenation of 'A's tail with 'B'. */
