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
