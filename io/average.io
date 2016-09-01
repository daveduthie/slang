// handle special case: division by 0
Number divide := Number getSlot("/")
Number / := method(denom,
	if(denom == 0, 0, self divide(denom))
)

List myAverage := method(
	if(/*self*/ select(i,v, v asNumber isNan == true) size > 0,
		Exception raise("It's not all numbers down here!"),
		(self sum) / (self size)
	)
)
myList := list(1,2,3,4,5,6,7,8,9,10)
myList myAverage println