"I'm using a for loop:" println

fib_loop := method(n,
	write("fib ", n, ": ")
	current := 0;
	next := 1;
	for(i, 1, n,
		tmp := next;
		next := current + next;
		current := tmp
	)
)

fib_loop(1) println
fib_loop(3) println
fib_loop(14) println
fib_loop(2) println
fib_loop(3) println
fib_loop(3) println
fib_loop(6) println
fib_loop(30) println

"I'm using recursion:" println

fib_recursive := method(n,
	if(n <= 1, n, fib_recursive(n - 1) + fib_recursive(n - 2) )
)

fib_recursive(1) println
fib_recursive(3) println
fib_recursive(14) println
fib_recursive(2) println
fib_recursive(3) println
fib_recursive(3) println
fib_recursive(6) println