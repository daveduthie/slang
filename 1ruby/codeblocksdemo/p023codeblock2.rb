# You can provide parameters to the call to yield:  
# these will be passed to the block  
def call_block  
  yield('hello', 99)  
end  
call_block {|str, num| puts str + ' ' + num.to_s}
# §
# the "to_s" method converts the "num" variable to a string.
# I discovered this using the interactive terminal and typing: 	x = 99
#																x.to_s
#																x.to_s.class

# §
# using yied with no returnable code block:

def try  
  if block_given?  
    yield  
  else  
    puts "no block"  
  end  
end  
try # => "no block"  
try { puts "hello" } # => "hello"  
try do puts "hello" end # => "hello"

# §
# code blocks and local variables:

x = 10  
5.times do |x|  
  puts "x inside the block: #{x}"  
end  
  
puts "x outside the block: #{x}"

# ----------

x = 10  
5.times do |x|  
  puts "x inside the block: #{x}"  
end  
  
puts "x outside the block: #{x}"

# ----------

x = 10  
5.times do |y|  
  x = y  
  puts "x inside the block: #{x}"  
end  
  
puts "x outside the block: #{x}"