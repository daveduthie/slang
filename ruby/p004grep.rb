# an attempt to write my own simple grep
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: tag-browser.rb [options]"

  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end

  opts.on("-pPATH", "--path PATH", "Specify input path (file or folder)") do |p|
    options[:path] = p
  end
  opts.on("-sSEARCH", "--search SEARCH", "Specify search term") do |s|
    options[:search] = s
  end
end.parse!

file = IO.readlines(options[:path]) unless options[:path].chr == "/"
file.each {|line| line.chomp!}

search = Regexp.new(gets.chomp)
matches = file.select {|line| line =~ search}
puts "Here are your matches:"
matches.each {|m| puts "  #{m}"}
