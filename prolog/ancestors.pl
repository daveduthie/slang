% This is Prolog!

father(adam, cain).
father(adam, abel).
father(cain, alex).
father(alex, peter).
father(peter, jim).

ancestor(X, Y) :- father(X, Y). % a '.' functions like a logical 'or'
ancestor(X, Y) :- father(X, Z), ancestor(Z, Y). % a ',' is like a logical 'and'

/*
X is an ancestor of Y if:
	- X is the father of Y
	(X -> Y)
or if:
	- X is the father of Z
	- Z is an ancestor of Y
	(X -> Y ... -> Z)
*/