require 'bundler'
Bundler.require

require_relative 'player'


class Game
  attr_accessor :human_player, :ennemies  #human_player est un HumanPlayer tandis que ennemies est un array qui contient des Players


  def initialize(human_player_name)

    @human_player = HumanPlayer.new(human_player_name)


    ennemy_1 = Player.new("Josiane")
    ennemy_2 = Player.new("José")
    ennemy_3 = Player.new("Jacky")
    ennemy_4 = Player.new("Janine")

    @ennemies = [ennemy_1, ennemy_2, ennemy_3, ennemy_4]
  end

  def kill_player(player_to_kill)  #Tout est déjà en string (la commande de PRY est rentrée en string) donc pas besoin de s'embêter. On fait toutes les values du tableau en attendant de tomber sur le nom qui correspond
    @ennemies.each do |player|
      if player.name == player_to_kill #On fait toutes les valeurs du tableau jusqu'à ce qu'on tombe sur le même nom.
    @ennemies.delete(player)
      end
    end

  end

  def is_still_ongoing?
    if (@human_player.life_points > 0 && @ennemies.length > 0) #On peut gérer avec la taille du tableau. S'il est vide, les ennemis sont morts
      return true
    else
      return false
    end
  end


  def show_players
   puts @human_player.show_state
   puts "Il reste #{@ennemies.length} ennemis"
  end

  def menu
    puts "appuyez sur entrée"
    gets.chomp
    puts "------------------------------------------------"
    puts "Quelle action veux-tu effectuer?"
    puts
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner"
    puts 
    puts "attaquer un joueur en vue:"
    for i in (0..@ennemies.length - 1)
      if @ennemies[i].life_points > 0 #On ne doit plus pouvoir taper un ennemi mort
        puts "#{i} - #{@ennemies[i].show_state}" #Je comprends pas pourquoi l'affichage foire.
      end
    end
    puts
  end

  def menu_choice
    gc = gets.chomp
    if gc == "a"
      @human_player.search_weapon
    elsif gc == "s"
      @human_player.search_health_pack
    elsif gc == "0"
      @human_player.attacks(@ennemies[0])  
    elsif gc == "1"
      @human_player.attacks(@ennemies[1])
    elsif gc == "2"
      @human_player.attacks(@ennemies[2])
    elsif gc == "3"
      @human_player.attacks(@ennemies[3])    #Malhreureusment, ce n'est pour l'instant pas dynamique en fonction du nombre de joueurs.
    elsif gc != "a" && gc !="s" && gc !="0" && gc != "1"
      puts 'Vous avez entré une mauvaise commande, votre tour passe!'       
    end    
    @ennemies.each do |player| #On supprime les ennemis qui ont succombé
      if player.life_points < 0
        kill_player(player.name)
      end
    end
  
  end



  def ennemies_attack
    @ennemies.each do |player| # Les ennemis vivants ripostent
      if @human_player.life_points > 0
        puts "Attention! un ennemi t'attaque!" 
        puts
      player.attacks(@human_player)
      puts
      end
    end
  end
  
  def end_game
    puts "La partie est finie"
    if @human_player.life_points > 0
      puts "BRAVO ! TU AS GAGNE !"
    else
      puts "Loser ! Tu as perdu !"
  end
end


end

