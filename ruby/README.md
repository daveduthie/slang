### Day 1

I came across a mention of different typing models. This article was quite helpful in explicating them:
[typing models](http://www.sitepoint.com/typing-versus-dynamic-typing/)

And here's a useful thread in the differences between compilers and interpreters: [C vs P](http://stackoverflow.com/questions/3265357/compiled-vs-interpreted-languages)

I've discovered that the Ruby interactive shell is called by `irb`.

#### Homework

- string substitution

Use the `gsub` method.

```ruby
"hello".gsub(/[aeiou]/, '*')                  #=> "h*ll*"
"hello".gsub(/([aeiou])/, '<\1>')             #=> "h<e>ll<o>"
"hello".gsub(/./) {|s| s.ord.to_s + ' '}      #=> "104 101 108 108 111 "
"hello".gsub(/(?<foo>[aeiou])/, '{\k<foo>}')  #=> "h{e}ll{o}"
'hello'.gsub(/[eo]/, 'e' => 3, 'o' => '*')    #=> "h3ll*"
```

- Index of a substring:

        "Hello, Ruby".index("Ruby")
        => 7

- print name ten times:

        irb(main):014:0> c = 0
        irb(main):015:0> until c == 10
        irb(main):016:1>    puts 'Yo Ho Ho'
        irb(main):017:1>    c = c + 1
        irb(main):018:1> end

- print "This is sentence number {1..10}"

        irb(main):028:0> c = 1
        irb(main):029:0> until c == 11
        irb(main):030:1>    puts 'This is sentence number', c
        irb(main):031:1>    c = c + 1
        irb(main):032:1> end

This line is better, because is prints the whole text on one line

        irb(main):030:1>    puts "This is sentence number #{c}"

### Day 2

On the programme:

- objects
- collections
- classes
- the code block
  - Here's a useful discussion of code blocks: http://rubylearning.com/satishtalim/ruby_blocks.html

#### The weird tree

there's illuminating info on the `visit` method as well as on the weird `&block` artifacts: `ri visit`

#### Mixins

For simplicity, each object should inherit its essence from only one class. If we want different behaviour from an object (new methods), we ought to tack on a module. This is called 'mixing in'.

In the book's example, the class implemented is called `Person`. We want to write the person's name to a file, but it seems unnatural to define file-writing methods inside the `Person` class. Writing information to a file isn't part of a person's essence. We therefore use a module to define the behaviour we want and just `include` it in the person class. Voilá!

#### Homework

1. Writing files with and without code blocks

```ruby
def filename
    "object_#{self.object_id}.txt"
end
def to_f_block(text)
    File.open(filename, 'w') {|f| f.write(text)}
end
def to_f_noblock(text)
    File.open(filename, 'w')
    File.write(text)
end
```

this throws an error:

```ruby
> ruby scratch.rb
scratch.rb:12:in `write': wrong number of arguments (given 1, expected 2..3) (ArgumentError)
from scratch.rb:12:in `to_f_noblock'
from scratch.rb:16:in `<main>'
```

Eureka! Using a code block saves me the labour of specifying all the arguments for the `write` method.

> “If there is a block after the open method then Ruby passes the opened stream to this block. At the end of the block, the file is automatically closed.”
>
> http://zetcode.com/lang/rubytutorial/io/

2. Translate hash to array

```ruby
my_hash = {:one => "yo", :two => "yoyo", :three => "yoyoyo"}
puts my_hash
my_array = Array.new
my_hash.each {|key, value| my_array.push([key, value])}
puts my_array
# phew!
```

Translate array to hash: use the `Array.to_h` method

3. Iterate through a hash

Easy. Use `my_hash.each`

4. What kind of data structures can Ruby arrays be used for?

IDK.

5. Print items in array, 4 at a time

```ruby
def array_fill(array,num)
  num.times do |elem|
    array.push(elem + 1)
  end
end

# without the array_slice method

def print_4(array)
  array.each_index do |i|
    ii = i + 1
    if ii % 4 == 0
      print array[ii - 4..ii - 1]
      puts ""
      puts "---------------"
    end
  end
end

# with the Array.slice method

def print_4_slice(array)
  until array.length == 0
    puts array[0..3]
    array.slice!(0..3)
    puts "---------------"
  end
end

a = []
array_fill(a,16)
print_4(a)

b = []
array_fill(b,16)
print_4_slice(b)
```

6. Adjust Tree class to accept nested hashes as input:

```ruby
class Tree
  attr_accessor :children, :node_name

  def initialize(parent, children)
    @node_name = parent
    @children = []
    if children != nil
      children.each do |k,v|
        @children.push(Tree.new(k,v))
      end
    end
  end

  def visit_all(&block)
    visit &block
    # § calls the `visit` method
    children.each {|c| c.visit_all &block} unless children == nil
  end

  def visit(&block)
    block.call self
  end
end

def new_tree(hash)
  Tree.new(hash.flatten[0], hash.flatten[1])
end

h = {'grandpa' => {
  'dad' => {
    'child 1' => {},
    'child 2' => {} },
  'uncle' => {
    'child 3' => {},
    'child 4' => {} } } }

ruby_tree = new_tree(h)

=begin
§
here's a diagram of the tree:
grandpa
 |    \
dad  uncle
| \   | \
c1 c2 c3 c4
=end

puts "Visiting a node"
ruby_tree.visit {|node| puts node.node_name}
puts

puts "visiting entire tree"
ruby_tree.visit_all {|node| puts node.node_name}
```

7. Write a grep

```ruby
# an attempt to write my own simple grep

file = IO.readlines("PUTSOMETHINGHERE")
file.each {|line| line.chomp!} # remove newline characters

print "What's your search term? "
search = Regexp.new(gets.chomp)
matches = file.select {|line| line =~ search} # create an array containing matches
puts "Here are your matches:"
matches.each {|m| puts "  #{m}"}
```

