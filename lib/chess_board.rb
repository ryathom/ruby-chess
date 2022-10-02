# frozen_string_literal: true
require_relative 'chess_piece'

class ChessBoard
  def initialize
    @board = Array.new(8) { Array.new(8, nil) }
    initial_setup
  end

  def visualize_board
    puts nil

    @board.each do |row|
      string = '  | '
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
    @board[0] = setup_non_pawns('black')
    @board[1] = setup_pawns('black')

    @board[6] = setup_pawns('white')
    @board[7] = setup_non_pawns('white')
  end

  def setup_pawns(color)
    Array.new(8) { Pawn.new(color) }
  end

  def setup_non_pawns(color)
    row = []

    row << Rook.new(color)
    row << Knight.new(color)
    row << Bishop.new(color)
    row << Queen.new(color)
    row << King.new(color)
    row << Bishop.new(color)
    row << Knight.new(color)
    row << Rook.new(color)

    row
  end

  def move_piece(piece, x, y)
    store = piece
    remove_piece(piece)
    @board[x][y] = store
  end

  def get_piece(x, y)
    @board[x][y]
  end

  def remove_piece(piece)
    @board.each_with_index do |row, i|
      row.each_with_index do |space, j|
        if space == piece
          @board[i][j] = nil
          return piece
        end
      end
    end
    nil
  end
end
