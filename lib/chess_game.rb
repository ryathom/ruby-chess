# frozen_string_literal: true

require_relative 'chess_board'
require_relative 'player'

CASTLING = /(([Oo0](-[Oo0]){1,2}))/
QUEENSIDE = /(([Oo0](-[Oo0]){2}))/

NON_PAWN = /[KQRBN][a-h]?[1-8]?x?[a-h][1-8]/
PAWN = /[a-h]?[1-8]?x?[a-h][1-8]([QRBN]?)/

class ChessGame
  def initialize
    @board = ChessBoard.new
    @players = [Player.new('white'), Player.new('black')]
  end

  def visualize_board
    @board.visualize_board
  end

  # ----------------------------------------
  # ---  Command interpretation methods  ---
  # ----------------------------------------
  def interpret_command(input)
    if castling?(input)
      if queenside?(input)
        queenside_castle_request
      else
        kingside_castle_request
      end
    end
  end

  def castling?(input)
    return true if input.match(CASTLING)

    false
  end

  def queenside?(input)
    return true if input.match(QUEENSIDE)

    false
  end

  def capture?(input)
    return true if input.match('x')

    false
  end

  def pawn?(input)
    return false if input.match(NON_PAWN)

    true
  end

  # ----------------------------------------
  # --------  Move request methods  --------
  # ----------------------------------------

  def queenside_castle_request
    puts "TODO"
  end

  def kingside_castle_request
    puts "TODO"
  end
end
