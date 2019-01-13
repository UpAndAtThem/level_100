require "socket"
require 'pry'

server = TCPServer.new("localhost", 3003)

class Dice
  attr_reader :sides

  def initialize(sides)
    @sides = sides
  end

  def roll
    rand(sides) + 1
  end
end

loop do
  client = server.accept
  first_line = client.gets

  next if !first_line || first_line =~ /favicon/

  http_method, path_and_params, http = first_line.split(" ")

  params = path_and_params.scan(/(\w+)=(\w+)/)
                          .map { |k,v| [k, v.to_i]}
                          .to_h

  path = path_and_params.match(/(\/\w*){0,}(?=\?*)/).to_s

  rolls = params['rolls']
  sides = params['sides']
  dice = Dice.new(sides)

  client.puts "HTTP/1.1 200 OK\r\n\r\n"
  client.puts "method : #{http_method}"
  client.puts "http : #{http}"
  client.puts "params : #{params}"
  client.puts "path_and_params : #{path_and_params}"
  client.puts "path : #{path}"
  client.puts ""
  client.puts "number_of_rolls : #{rolls}"
  client.puts "sides_on_dice : #{sides}"

  sum_of_rolls = rolls.times.reduce(0) do |memo, roll_index| 
    roll = dice.roll
    client.puts "roll #{roll_index + 1}: #{roll}"
    memo += roll
  end

  client.puts "sum_of_rolls : #{sum_of_rolls}"

  client.close
end