require 'socket'

server = TCPServer.new("localhost", 3003)

loop do
  client = server.accept
  first_req_line = client.gets

  next if first_req_line =~ /favicon/

  http_method, path_and_params, http = first_req_line.split

  params = path_and_params.scan(/(\w+)=(\w+)/).map{ |key, value| [key, value.to_i]}.to_h
  num = params['num']

  text = <<~TEXT
  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur est ante, porttitor ut dui nec, vestibulum scelerisque neque. Donec molestie pretium tincidunt. Vestibulum aliquam tellus feugiat velit efficitur posuere. Etiam ut hendrerit nisi. Nunc pretium cursus neque, vitae eleifend purus tempor imperdiet. Donec blandit mattis fermentum. Cras viverra lacus arcu, et scelerisque lectus rhoncus nec. Proin fringilla, purus pellentesque pharetra rhoncus, dolor nunc egestas nulla, et venenatis ipsum metus et dui.\n\n
  Nullam interdum tortor tellus, vitae blandit velit pulvinar ut. Quisque efficitur, magna sed aliquet interdum, mi massa congue turpis, vitae pellentesque nunc felis ac ligula. Sed consectetur maximus ante, vitae consectetur enim pretium a. In a elit id erat tristique dapibus. Vestibulum lacinia malesuada tellus vel semper. Nullam et elit ut augue bibendum molestie. Phasellus nec volutpat quam. Nam efficitur felis eu erat placerat, id tristique lacus scelerisque. Nam urna nisi, vulputate eget suscipit quis, scelerisque auctor nibh. Nullam at enim vel erat elementum pulvinar. Phasellus dignissim tellus eu feugiat efficitur. Nulla facilisi. Nam fringilla sapien ante, eu cursus nisi placerat a. Ut faucibus metus sed risus vehicula, eu feugiat magna porttitor. In fermentum est non eros tincidunt mattis. Fusce in arcu fringilla, pulvinar nibh efficitur, tincidunt nisi.\n\n
  Pellentesque semper leo risus, sit amet sodales nisi pretium et. Ut faucibus sed mi non pretium. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Morbi fermentum lorem ullamcorper lacus egestas porta. Pellentesque placerat dapibus consectetur. Duis felis lorem, efficitur nec ipsum in, tristique tempus velit. Nulla facilisi. Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n\n
  Etiam ac tellus ultricies, fermentum justo id, gravida arcu. Pellentesque sed urna hendrerit, dictum velit vitae, faucibus metus. Suspendisse sem neque, volutpat eu viverra ut, congue vitae nunc. Nulla sit amet feugiat leo. Quisque vel est fermentum, facilisis eros et, imperdiet augue. Donec non luctus lectus, ac gravida ligula. Aenean dignissim urna non cursus cursus. Ut aliquam ac nulla non pretium. Aenean ut porta nibh. Suspendisse commodo, erat sed consequat iaculis, purus lectus rutrum lorem, sed porttitor lectus est vel erat. Etiam bibendum massa vitae tempor commodo. Aenean maximus elit ac aliquet finibus. Nullam ac eros id ipsum tincidunt pellentesque a quis sapien.\n\n
  TEXT

  client.puts "HTTP/1.1 200 OK\r\n\r\n"
  client.puts "<!DOCTYPE html>"
  client.puts "<html>"
  client.puts "<style>"
  client.puts "h1 {color: green}"
  client.puts "p {color: red}"
  client.puts "a {display: block};"
  client.puts "</style>"
  client.puts "<h1>HELLO WORLD!</h1>"
  client.puts "<h2>#{num}</h2>"
  client.puts "<p>#{text}</p>"
  client.puts "<a href='?num=#{num + 1}'>NEXT NUM</a>"
  client.puts "<a href='?num=#{num - 1}'>PREV NUM</a>"
  client.puts "</html>"
  client.close
end
