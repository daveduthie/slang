futureResult := URL with("http://google.com/") @fetch

writeln("This will block until the result is available.")
// this line will execute immediately

writeln("fetched ", futureResult size, " bytes")
// this will block until the computation is complete
// and Io prints the value
