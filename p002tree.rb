require 'pry'

class Tree
	attr_accessor :children, :node_name

	def initialize(name, children=[])
		@children = children
		@node_name = name
		# § 
		# when we instantiate the tree, 
		# @node_name is set to "Ruby" 
		# and @children is set to an array 
		# containing "Reia" and "Macruby"
	end

	def visit_all(&block)
		visit &block
		# § calls the `visit` method
		children.each {|c| c.visit_all &block}
	end

	def visit(&block)
		block.call self
	end
end

ruby_tree = Tree.new(
	"Ruby",	[
		Tree.new("Reia"),
		Tree.new("MacRuby"),
		Tree.new("Unicorn", [
			Tree.new("Claus"),
		 	Tree.new("Santa Ragione")
		 	])
		] 
	)

# §
# here's a diagram of the tree:
# Ruby
# |	  \
# |	   \
# Reia  MacRuby

puts "Visiting a node"
ruby_tree.visit {|node| puts node.node_name}
puts

puts "visiting entire tree"
binding.pry
ruby_tree.visit_all {|node| puts node.node_name}