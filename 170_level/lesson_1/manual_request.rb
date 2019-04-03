require 'socket'

server = TCPServer.new("localhost", 2000)

loop do
  client = server.accept
  http_method, qs, http = client.gets.split(" ")

  num = qs.match(/\w+=-*\w+/).to_s.split("=").last.to_i

  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/html\r\n\r\n"

  client.puts "<html>" 
  client.puts "<body>"
  client.puts "<p>CURRENT NUM: #{num}</p>"
  client.puts "<a href='/num=#{num - 1}'>previous num</a>"
  client.puts "<a href='/num=#{num + 1}'>next num</a>"
  client.puts "</body>"
  client.puts "</html>"

  client.close
end