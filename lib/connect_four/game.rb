# frozen_string_literal: true

# class Game
class Game
  attr_accessor :players, :board, :current_player, :other_player
  def initialize(players, board = Board.new)
    @players = players
    @board = board
    @current_player, @other_player = players.shuffle
  end

  def play
    puts "#{current_player.name} is selected at random to make the first move!"
    loop do
      column = move
      board.set_value(column, current_player.color)
      if board.winner? || board.draw?
        game_over_message
        return
      end
      switch_players
    end
  end

  private

  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end

  def move
    loop do
      solicit_move
      human_move = gets.chomp.to_i
      return human_move - 1 if (1..7).include?(human_move) && board.full_column?(human_move - 1) == false

      puts 'Invalid move'
    end
  end

  def game_over_message
    puts "#{current_player.name} WINS!" if board.winner?
    puts 'The game ends in a draw.' if board.draw?
    board.print_grid
  end

  def solicit_move
    board.print_grid
    puts "#{current_player.name}'s turn(Enter a column number between 1 - 7): "
  end
end
