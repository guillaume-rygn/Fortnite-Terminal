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
def game_init
  puts "Quel est ton nom de joueur"
  print "> "
  name = gets.chomp
  puts "Contre combien de joueur veux tu jouer ?"
  print "> "
  nb = gets.chomp.to_i
  game = Game.new(name,nb)
  return game
end

def perform
  welcome
  game = game_init
  game.menu_choice
  game.end
end

perform