require "socket"

server = TCPServer.new("localhost", 3003)

loop do
  client = server.accept
  first_request_line = client.gets

  http_method, path_and_params, http = first_request_line.split(" ")
  params = path_and_params.scan(/(\w+)=(\w+)/).to_h
  path = path_and_params.match(/\/\w+(?=\?*)/).to_s

  client.puts "HTTP/1.1 200 OK\r\n\r\n"
  client.puts "method : #{http_method}"
  client.puts "http : #{http}"
  client.puts "params : #{params}"
  client.puts "path_and_params : #{path_and_params}"
  client.puts "path : #{path}"

  client.close
end
