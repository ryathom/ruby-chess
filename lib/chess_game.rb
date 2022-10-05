# frozen_string_literal: true

require_relative 'chess_board'
require_relative 'player'

CASTLING = /(([Oo0](-[Oo0]){1,2}))/
QUEENSIDE = /(([Oo0](-[Oo0]){2}))/

NON_PAWN = /[KQRBN][a-h]?[1-8]?x?[a-h][1-8]/

PAWN = /[a-h]?[1-8]?x?[a-h][1-8]([QRBN]?)/
PAWN_PROMO = /[a-h]?[1-8]?x?[a-h][1-8][QRBN]/


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

    if pawn?(input)
      if capture?(input)
        pawn_capture_request(input)
      else
        pawn_move_request(input)
      end

      if pawn_promo?(input)
        pawn_promo_request(input)
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
  
  def pawn_promo?(input)
    return true if input.match(PAWN_PROMO)

    false
  end

  def split_command(input)
    obj = input.scan(SPLIT_COMMAND)[0].reject {|e| e.nil? | e.empty?}
    p obj
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

  def pawn_move_request(input)
    puts "TODO"
  end

  def pawn_capture_request(input)
    puts "TODO"
  end

  def pawn_promo_request(input)
    puts "TODO"
  end
end
