require 'socket'

server = UNIXServer.new('/tmp/simple.sock')

puts "==== Waiting for connection"
socket = server.accept

puts "==== Got Request:"
puts socket.readline

puts "==== Sending Response"
socket.write("I read you loud and clear, good buddy!")

socket.close