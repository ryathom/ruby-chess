# frozen_string_literal: true
require_relative 'chess_piece'

class ChessBoard
  def initialize
    @board = Array.new(8) { Array.new(8, nil) }
    initial_setup
  end

  def visualize_board
    @board.each do |row|
      string = '| '
      row.each do |space|
        if space.nil?
          string += '_'
        else
          string += space.symbol
        end
        string += ' | '
      end
      puts string
    end
    puts nil
  end

  def initial_setup
    8.times { |i| @board[0][i] = ChessPiece.new('black')}
    8.times { |i| @board[1][i] = ChessPiece.new('black')}

    8.times { |i| @board[6][i] = ChessPiece.new('white')}
    8.times { |i| @board[7][i] = ChessPiece.new('white')}
  end 
end
