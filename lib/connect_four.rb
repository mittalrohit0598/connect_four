# frozen_string_literal: true

require_relative 'connect_four/cell'
require_relative 'connect_four/board'
require_relative 'connect_four/player'
require_relative 'connect_four/game'

puts 'Enter name of player 1: '
player1 = gets.chomp
puts 'Enter name of player 2: '
player2 = gets.chomp

player1 = Player.new(player1, "\u2691")
player2 = Player.new(player2, "\u2690")
game = Game.new([player1, player2])
game.play
