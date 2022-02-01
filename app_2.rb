require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

#message de bienvenue aux joueurs
  def welcome
    puts "\n\n---------------------------------------"
    puts "|   Bienvenue sur Fortnite Terminal   |"
    puts "|                 ---                 |"
    puts "|   Soit le dernier a rester en vie   |"
    puts "---------------------------------------\n\n"
  end

#initialisation du joueur humain
  def human_init
    puts "Quel est ton nom de joueur"
    print "> "
    name = gets.chomp
    human = HumanPlayer.new(name)
    puts "\n\nBienvenue #{human.name}, tu es inscrit au prochain combat voici tes attribues :"
    puts human.show_state 
    puts "------------------------------------------------------------\n\n"
    return human
  end

#initialisation des ennemis
  def ennemis_init
    ennemis = []
    player1 = Player.new("Josiane")
    player2 = Player.new("José")

    ennemis.push(player1,player2)
    return ennemis
  end

#C'est l'heure du combat pour déterminer le vainqueur! 
def fight (human,ennemis)
  puts "--------------------------"
  puts "| Bienvenue dans l'arène |"
  puts "--------------------------\n\n"

  while human.life_points > 0 && (ennemis[0].life_points > 0 || ennemis[1].life_points >0)
      puts human.show_state

      puts"Quelle action veux-tu effectuer ?\n\n"
      puts "a - chercher une meilleure arme"
      puts "s - chercher à se soigner "
      puts "\n\nattaquer un joueur en vue :"
      if ennemis[0].life_points > 0 
        print "\n0 - "
        print "#{ennemis[0].show_state}"
      end
      if ennemis[1].life_points > 0 
        print "\n1 - "
        print "#{ennemis[1].show_state}\n"
      end
      
      puts "\n\nFais ton choix :"
      print "> "
      choice = gets.chomp
      
      case choice
        when "a" 
          puts "----------------------------------------------\n\n"
          human.search_weapon
        when "s"
          puts "----------------------------------------------\n\n"
          human.search_health_pack
        when "0"
          puts "----------------------------------------------\n\n"
          human.attacks(ennemis[0])
        when "1"
          puts "----------------------------------------------\n\n"
          human.attacks(ennemis[1])
        else 
          puts "Merci de saisir une valeur ci-dessus"
          print "> "
          choice = gets.chomp
      end

      puts "\nfin de ton tour\n"
      puts "Appuie sur une touche pour continuer"
      gets.chomp
      puts "----------------------------------------------\n\n"
      
      
      ennemis.each do |ennemis|
        if ennemis.life_points > 0
          puts "un autre joueur t'attaquent!"
          ennemis.attacks(human)
        end
      end
      
      puts "\nC'est ton tour !\n"
      puts "Appuie sur une touche pour continuer"
      gets.chomp
      puts "\n\n----------------------------------------------\n\n"
  end
  
  puts "La partie est finie\n\n"
  
  if human.life_points > 0 
    puts "BRAVO CHAMPION! TU AS GAGNE !"
  else
    puts "Loser ! Tu as perdu !"
  end
end


#methode global pour run le programme
  def perform
    welcome
    human = human_init
    ennemis = ennemis_init
    fight(human, ennemis)
  end

perform