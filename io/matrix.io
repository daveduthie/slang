/*
cordmata does this very cleanly. check it out
Perhaps he read the List section thoroughly in the Io Reference. Here's his dim() method:

Matrix dim := method(x, y,
  m := Matrix setSize(y)
  m mapInPlace(v, list() setSize(x))
)

*/

// create dim() method
Matrix := List clone
Matrix dim := method(x,y,
  InnerList := List clone setSize(x)
  y repeat(self append(InnerList clone))
  self
)

// create set() method
Matrix set := method(x,y,value,
  self at(y) atPut(x,value)
)

// create get() method
Matrix get := method(x,y,
  self at(y) at(x)
)

// create display method
Matrix show := method(
  self foreach(l, l println)
)

"x: 3 y: 2 matrix" println
l := Matrix clone dim(3,2)
l show
l set(0,0,1)
l show
l get(0,0) println
