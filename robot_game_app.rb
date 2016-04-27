require "./robot_game"

game = RobotGame.new
commands = []
previous_was_placement = false
ARGV.each do |arg|
  if arg == "PLACE"
    previous_was_placement = true
  elsif previous_was_placement
    place_arg = arg.split(',')
    commands << [:place, *place_arg]
    previous_was_placement = false
  else
    commands << arg.downcase.to_sym
  end
end

unless commands.size > 0
  puts "Usage:"
  puts "\trobot_game_app.rb COMMANDS"
end

commands.each do |command|
  begin
    result = game.public_send(*command)
    if command == :report
      puts "Current position #{game.report}"
    end
  rescue NoMethodError
    puts "Ignoring invalid command: #{command}"
  end
end

puts "Game finished. Current position #{game.report}"
