# an attempt to write my own simple grep

file = IO.readlines("notes/Pragmatic Programmer - Ruby - Journal.md")
file.each {|line| line.chomp!}

print "What's your search term? "
search = Regexp.new(gets.chomp)
matches = file.select {|line| line =~ search}
puts "Here are your matches:"
matches.each {|m| puts "  #{m}"}