# frozen_string_literal: true

require_relative 'chess_board'

class ChessGame
  def initialize
    @board = ChessBoard.new
  end

  def visualize_board
    @board.visualize_board
  end
end
