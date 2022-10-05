# frozen_string_literal: true

require_relative 'chess_board'
require_relative 'player'

CASTLING = /(([Oo0](-[Oo0]){1,2}))/
QUEENSIDE = /(([Oo0](-[Oo0]){2}))/

NON_PAWN = /[KQRBN][a-h]?[1-8]?x?[a-h][1-8]/

PAWN = /[a-h]?[1-8]?x?[a-h][1-8]([QRBN]?)/
PAWN_PROMO = /[a-h]?[1-8]?x?[a-h][1-8][QRBN]/

SPLIT_COMMAND = /([KQRBN]?)([a-h]?[1-8]?)(x?)([a-h][1-8])([QRBN]?)/


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
    else
      command = split_command(input)
      piece = command[0]
      disambig = command[1]
      capture = command[2]
      target_addr = command[3]
      promo = command[4]

      request_command(piece, disambig, capture, target_addr, promo)
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

  def split_command(input)
    obj = input.scan(SPLIT_COMMAND)[0]
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

# game = ChessGame.new

# game.split_command('e6')
# game.split_command('Ke6')
# game.split_command('Kxe6')
# game.split_command('K4xe6')
# game.split_command('Kdxe6')
# game.split_command('Kd4xe6')