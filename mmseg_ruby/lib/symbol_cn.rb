require 'singleton'

class SymbolCn
	include Singleton

	attr_accessor :lib

	def initialize
		@lib = File.open("../symbollib.txt","r").read.each_line.collect{|line|
			line.gsub("\n","")
		}
	end
end