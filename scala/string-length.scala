val strings = List("Tim", "Alice", "Robot", "Unicornsaurus")
val stringsLength = (0 /: strings) {(sum, str) =>
  sum + str.length
}

println("strings: " + strings)
println("total length: " + stringsLength)
