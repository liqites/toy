class Node
	attr_accessor :parent,:children,:value
	
	def add_child(node)
		@children << node
	end
	
	def remove_child(node)
		if (c = @children.select{|c|c == node}.length)== 1
			@children.delete(c)
			true
		else
			false	
		end
	end
end