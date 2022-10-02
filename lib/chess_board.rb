# frozen_string_literal: true

class ChessBoard
  def initialize
    @board = Array.new(8) { Array.new(8, nil) }
  end

  def visualize_board
    @board.each do |row|
      string = '| '
      row.each do |space|
        string += '_' if space.nil?
        # string += piece.symbol if space.piece?
        string += ' | '
      end
      puts string
    end
    puts nil
  end
end
