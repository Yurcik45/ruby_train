require 'socket'
server = TCPServer.new 5000

# while session = server.accept
#   session.puts "Hello world! The time is #{Time.now}"
#   session.close
# end

# while line = server.gets
#   puts line
# end

while session = server.accept
  request = session.gets
  puts request
 
  session.print "HTTP/1.1 200\r\n" # 1
  session.print "Content-Type: text/html\r\n" # 2
  session.print "\r\n" # 3
  session.print "Hello world! The time is #{Time.now}" # 4
 
  session.close
end