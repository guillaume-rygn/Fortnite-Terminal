require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

#Message de bienvenue
  def welcome
    puts "\n\nBienvenue dans ce nouveau combat :\n\n"
  end

#initialisation du joueur 1
  def player_init1
    player1 = Player.new("Josiane")
    puts "A ma droite #{player1.name}"
    return player1
  end

#initialisation du joueur 2
  def player_init2
    player2 = Player.new("José")
    puts "A ma gauche #{player2.name}"
    return player2
  end

#affichage de l'état des joueurs
  def player_show_state (player1, player2)
    puts "\n\nVoici l'état de chaque joueur :\n"
    puts player1.show_state
    puts player2.show_state
  end

#C'est l'heure du combat ! 
  def fight (player1,player2)
    while player1.life_points > 0 || player2.life_points > 0
      player_show_state(player1, player2)
      puts "\n\nPassons à la phase d'attaque :\n\n"
      player1.attacks(player2)
            
      if player2.life_points <= 0 
        break
      else
        player2.attacks(player1)
      end

    end
  end

#perform global pour lancer le programme
  def perform
    welcome
    player1 = player_init1
    player2 = player_init2

    fight(player1, player2)
  end

perform
