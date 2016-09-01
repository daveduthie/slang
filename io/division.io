"before modification:" println
1/3 println
1/0 println

Number divide := Number getSlot("/")
Number / := method(denom,
	if(denom == 0, 0, self divide(denom))
)

"after modification:" println
1/3 println
1/0 println

"Note: even before modification, 1 / 0 prints 0 but the return value used to be inf." println
