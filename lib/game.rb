#VERSION 3
require 'pry'
require_relative './player'

class Game 
  attr_accessor :human_player, :ennemis

#initialisation de la classe Game
  def initialize (name,nb_ennemis)
    @human_player = HumanPlayer.new(name)
    @ennemis = []
    for i in 1..nb_ennemis do
      @ennemis << Player.new("player#{i}")
    end
  end

#methode qui retire les joueurs tué de l'array ennemis
  def kill_player(player)
    ennemis.each do |bot|
      if bot.name == player
        ennemis.delete(bot)
      end
    end
  end

#méthode qui demande si le jeu est toujours en cours : renvoi true ou false
  def is_still_ongoing?
    if human_player.life_points > 0 || ennemis.empty?
      return true
    else
      return false
    end
  end

#méthode qui affiche l'état du joueur humain et le nombre de bot restant
  def show_player
    puts "\n\n"
    puts human_player.show_state
    puts "\nIl reste #{ennemis.length} ennemis sur la carte"
  end



#méthode qui permet d'afficher un menu
  def menu 
    puts 
    puts "--------------------------------------------------------"
    puts self.show_player
    puts "\n--------------------------------------------------------"
    puts
    puts "------------------------------------"
    puts "| C'est l'heure de faire des choix |"
    puts "------------------------------------\n\n"
    
    

    puts"\nQuelle action veux-tu effectuer ?\n\n"
    puts "7000 - chercher une meilleure arme"
    puts "8000 - chercher à se soigner "
    puts "\n\nattaquer un joueur en vue :"
      ennemis.each do |bot|
        if bot.life_points > 0 
          print "\n#{ennemis.index(bot)} - "
          print "#{bot.show_state}"
        end
      end
  end


#methode pour choisir une action
  def menu_choice
    
      while human_player.life_points > 0 && ennemis[0] != nil
      menu()
      puts "\n\nFais ton choix :"
      print "> "
      choice = gets.chomp.to_i

      case choice
      when 7000 
        puts "----------------------------------------------\n\n"
        human_player.search_weapon
      when 8000
        puts "----------------------------------------------\n\n"
        human_player.search_health_pack
      
      when 0..ennemis.length
        puts "----------------------------------------------\n\n"
        human_player.attacks(ennemis[choice])
          if ennemis[choice].life_points <= 0
            kill_player(ennemis[choice].name)
          end
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
          puts "un autre joueur t'attaque! c'est #{ennemis.name}\n"
          ennemis.attacks(human_player)
        end
      end

      if ennemis[0] != nil
        puts "\nC'est ton tour !\n"
        puts "Appuie sur une touche pour continuer"
        gets.chomp
        puts "\n\n--------------------------------------------------------\n\n"
      end
    end
  end

  #methode de fin de partie
  def end
    puts "La partie est finie\n\n"
    
    if human_player.life_points > 0 
      puts "BRAVO CHAMPION! TU AS GAGNE !"
    else
      puts "Loser ! Tu as perdu !"
    end
  end

end





#binding.pry