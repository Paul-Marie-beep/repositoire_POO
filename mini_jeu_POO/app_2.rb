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
user = HumanPlayer.new(gets.chomp)
player1 = Player.new("Josiane")
player2 = Player.new("José")
ennemies = [player1, player2]

while user.life_points >0 && (player1.life_points > 0 || player2.life_points >0)
  puts "appuyez sur entrée"
  gets.chomp
  puts user.show_state
  puts "Quelle action veux-tu effectuer?"
  puts
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner"
  puts 
  puts "attaquer un joueur en vue:"
  print "0 - #{player1.show_state}" #mettre la solution de Laurent pour les avoir sur la  même ligne
  print "1 - #{player2.show_state}"

  g = gets.chomp

  if g == "a"
    user.search_weapon
  elsif g == "s"
    user.search_health_pack
  elsif g == "0"
    user.attacks(player1)
  elsif g == "1"
    user.attacks(player2)
  elsif g != "a" && g !="s" && g !="0" && g != "1"
    puts 'Vous avez entré une mauvaise commande, votre tour passe!' 
  end

  puts
  puts "appuyez sur entrée"
  gets.chomp
  
  ennemies.each do |player|
    if player.life_points > 0
      puts "Attention! Les ennemis t'attaquent!" 
    player.attacks(user)
    puts
    end
  end

end
puts "La partie est finie"
if user.life_points > 0
  puts "BRAVO ! TU AS GAGNE !"
else
  puts "Loser ! Tu as perdu !"
end
