require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'


puts "------------------------------------------------"
puts "|Bienvenue sur 'Ils veulent tous ma POO!'      |"
puts "|Le but du jeu est d'être le dernier survivant!|"
puts
puts "Quel est ton prénom?"
puts ">"

my_game = Game.new(gets.chomp)

while my_game.is_still_ongoing? 
  puts my_game.show_players
  my_game.menu
  my_game.menu_choice
  puts
  puts "------------------------------------------------"
  gets.chomp
  my_game.ennemies_attack
end

my_game.end_game


