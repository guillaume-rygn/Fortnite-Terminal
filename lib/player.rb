#VERSION 1.0

class Player
  attr_accessor :name, :life_points

#initialisation du joueur
  def initialize(name)
    @name = name
    @life_points = 10
  end

#method permettant de voir la vie du joueur à un instant T
  def show_state
    print "#{@name} a #{@life_points} points de vie"
  end

#method permettant d'affliger des dégats au joueur et définir si il est mort ou non 
  def get_damage(damage)
    @life_points -= damage
  end

#method permettant d'effectuer l'attaque entre les joueurs
  def attacks(player)
    puts "Le joueur #{@name} attaque le joueur #{player.name}"

    damage = compute_damage()
    player.get_damage(damage)

    puts "#{@name} a infligé #{damage} points de dommages à #{player.name}\n\n"
    
    if player.life_points <= 0 
      puts "#{@name} a tué #{player.name}"
    end
  end

#method qui calcul automatiquement les dommages d'une attaque entre 1 et 6
  def compute_damage
    return rand(1..6)
  end

end



#VERSION 2.0

class HumanPlayer < Player
  attr_accessor :weapon_level

#initialisation du HumanPlayer prenant l'héritage de Player  
  def initialize(name)
    super(name) 
    @weapon_level = 1
    @life_points = 100
  end

#Héritage de la méthode show_state récupéré (grâce à super) auquel on lui attribut un nouvel élément
  def show_state
    super
    print " et une arme de niveau #{@weapon_level}"
  end

#Héritage de la méthode compute_damage récupéré (grâce à super) auquel on lui attribut un élément multiplicatif (@weapon_level)
  def compute_damage
    super * @weapon_level
  end

#Methode pour trouver une arme plus puissante ou pas
  def search_weapon
    level = rand(1..6)
    puts "\n\nTu as trouvé une arme de niveau #{level}"

    if @weapon_level < level
      unité = level - @weapon_level
      @weapon_level = level
      puts "> Cette arme est incroyablement plus forte de #{unité} unité que ton arme actuelle ! tu la prends !\n\n"
    else
      puts "> M@*#$... elle n'est pas mieux que ton arme actuelle... tu ne la prends pas\n\n"
    end
  end

#Methode pour trouver obtenir de la vie en plus ou pas
  def search_health_pack
    level = rand(1..6)

    case level
    when 1
      puts "Tu n'as rien trouvé... "

    when 2..5
      @life_points += 50
      
      if @life_points > 100
        @life_points = 100
      end

      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
    
    when 6 
      @life_points += 80
      
      if @life_points > 100
        @life_points = 100
      end

      puts "Waow, tu as trouvé un pack de +80 points de vie !"
    end
  end

end
