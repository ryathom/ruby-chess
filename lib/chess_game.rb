# frozen_string_literal: true

require_relative 'chess_board'
require_relative 'player'

class ChessGame
  def initialize
    @board = ChessBoard.new
    @players = [Player.new('white'), Player.new('black')]
  end

  def visualize_board
    @board.visualize_board
  end
end
