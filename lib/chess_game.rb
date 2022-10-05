# frozen_string_literal: true

require_relative 'chess_board'
require_relative 'player'

CASTLING = /(([Oo0](-[Oo0]){1,2}))/

class ChessGame
  def initialize
    @board = ChessBoard.new
    @players = [Player.new('white'), Player.new('black')]
  end

  def visualize_board
    @board.visualize_board
  end

  # def interpret_command(input)
  #   if castling?(input)
  # end

  def castling?(input)
    return true if input.match(CASTLING)

    false
  end
end
