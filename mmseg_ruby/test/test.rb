#encoding: utf-8

load '../scanner.rb'
load '../lib/content.rb'

puts "...........test start..........."

#a = File.open("../狗这一辈子_bak.txt","r")
#c = Content.new(a.read)
#Scanner.simple_maximum_match(content)

c = Content.new("太厉害不行，太懦弱不行")
Scanner.simple_maximum_match(c)
Scanner.complex_maximum_macth(c)

puts "............test end............"