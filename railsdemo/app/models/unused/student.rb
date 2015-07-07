# class Student
# 	attr_accessor :count
#
# 	extend ActiveModel::Callbacks
#
# 	define_model_callbacks :create
#
# 	before_create :do_one_thing,:do_two_thing
# 	before_create :do_one_thing,:do_two_thing,:do_three_thing
#
# 	def initialize()
# 		@count = 0
# 	end
#
# 	def create
# 		run_callbacks :create do
# 			puts "Actually Create"
# 		end
# 	end
#
# 	def test(*opt)
# 		puts opt.extract_options!
# 		puts opt
# 	end
#
# 	def do_one_thing
# 		@count = @count + 1
# 		puts "Do #{@count}"
# 	end
#
# 	def do_two_thing
# 		@count = @count + 1
# 		puts "Do #{@count}"
# 	end
#
# 	def do_three_thing
# 		@count = @count + 1
# 		puts "Do #{@count}"
# 	end
# end
