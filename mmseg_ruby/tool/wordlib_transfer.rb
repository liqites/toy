class WordlibTransfer
	def self.transfer(source,des,encoding = nil)
		source = File.open(source,"r:GB18030")
		File.delete(des)
		des = File.open(des,"w:GB18030")

		source.each_line {|line|
			str = line.split((" ".force_encoding("GB18030")))[1]
			des.puts str
		}
		des.close
	end
end