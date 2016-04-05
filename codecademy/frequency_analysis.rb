puts "give me something to analyse: "
text = gets.chomp
words = text.split
frequencies = Hash.new(0)
words.each do |w|
    frequencies[w] += 1
end
frequencies = frequencies.sort_by do |word,frequency|
    frequency
end
frequencies.reverse!
frequencies.each do |word,frequency|
    puts "#{word} #{frequency}"
end