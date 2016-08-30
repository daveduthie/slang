-module(shopping).
-export([totalPerItem/1]).

totalPerItem(Cart) -> [{Item, Quantity * Price} || {Item, Quantity, Price} <- Cart].
