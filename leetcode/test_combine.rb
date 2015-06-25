class TestCombine
	def combine(n,k)
		#build tree
		array = (1..n).to_a
		root = Node.new({parent:nil,value:nil})
		array.each do |a|
			child = Node.new({parent:root,value:a})
		end
		
	end
end