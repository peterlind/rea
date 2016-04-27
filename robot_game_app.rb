#! /usr/bin/env ruby

require "./robot_game"

game = RobotGame.new
commands = []
previous_was_placement = false

command_list =
  if !STDIN.tty?
    STDIN
  else
    ARGV
  end

command_list.each do |arg|
  if arg =~ /PLACE\z/
    previous_was_placement = true
  elsif arg =~ /PLACE/
    place_arg = arg.split(' ')[1].split(',')
    commands << [:place, *place_arg]
  elsif previous_was_placement
    place_arg = arg.split(',')
    commands << [:place, *place_arg]
    previous_was_placement = false
  else
    commands << arg.strip.downcase.to_sym
  end
end

unless commands.size > 0
  puts "Usage:"
  puts "\trobot_game_app.rb COMMANDS"
  puts "\trobot_game_app.rb < file-with-commands"
  exit 1
end

commands.each do |command|
  begin
    result = game.public_send(*command)
    if command == :report
      puts "Current position #{result}"
    end
  rescue NoMethodError
    puts "Ignoring invalid command: #{command}"
  end
end

puts "Game finished. Current position #{game.report}"
