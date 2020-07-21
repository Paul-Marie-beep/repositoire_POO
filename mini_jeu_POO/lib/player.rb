require 'pry'

class Player
  attr_accessor :name, :life_points

  def initialize(name)
    @name = name
    @life_points = 10
  end

  def show_state
    if @life_points > 0 #On montre l'état des ennmemis vivants
      puts "#{name} a #{@life_points} points de vie"
    else
      puts "#{name} est mort"
    end
  end

  def gets_damage(damage) #damage va être un integer donné à la fonction
    @life_points = @life_points - damage
    if @life_points <= 0 #Un ennemi sans PV est mort
      puts "#{name} a été tué"
    end
  end


  def attacks(player)
    puts "#{name} attaque #{player.name}"
    d = compute_damage #Cf.fontion suivante
    puts "Il lui inflige #{d} points de dommages"
    player.gets_damage(d) #Cf. fonction précédente
  end


  def compute_damage
    return rand(1..6) #On obtient un nombre aléatoire entre 1 et 6.
  end
end

class HumanPlayer < Player #La classe HumanPlayer hérite des attributs de la classe Player
  attr_accessor :weapon_level

  def initialize(name)
    @name = name
    @life_points = 100
    @weapon_level = 1
  end

  def show_state
    print "#{name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
  end

  def compute_damage
    return rand(1..6) * @weapon_level #On multiplie les dégats par le niveau de l'arme.
  end

  def search_weapon
    de = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{de}"
    if de > @weapon_level #Si on trouve une arme de niveau plus élévé, on la prend. Dans le cas contraire, on la jette.
      @weapon_level = de
    else
      puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
    end
  end

  def search_health_pack
    de_2 = rand(1..6)
    if de_2 == 1
      puts "Tu n'as rien trouvé... "
    elsif de_2 > 1 && de_2 < 6 #On va refaire une boucle pour être sûr qu'un joueur humain ne puisse pas avoir plus de 100PV qui est son max
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
      if @life_points < 50 
         @life_points = @life_points + 50
      else
        @life_points = 100
      end
    else #Il ne reste plus que le cas ou le dé rend un 6
      puts "Waow, tu as trouvé un pack de +80 points de vie !"  
      if @life_points < 80 # La même, on s'assure que le joueur ne puisse pas avoir plus de 100PV
        @life_points = @life_points + 80
      else
        @life_points = 100
      end
    end
    return @life_points

  end


end




#binding.pry
#puts "End of file"