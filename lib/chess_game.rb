# frozen_string_literal: true

require_relative 'chess_board'
require_relative 'player'

CASTLING = /(([Oo0](-[Oo0]){1,2}))/
QUEENSIDE = /(([Oo0](-[Oo0]){2}))/

SPLIT_COMMAND = /([KQRBN]?)([a-h]?[1-8]?)(x?)([a-h][1-8])([QRBN]?)/


class ChessGame
  def initialize
    @board = ChessBoard.new
    @players = [Player.new('white'), Player.new('black')]
    @current_player = @players[0]
  end

  def visualize_board
    system 'clear'
    @board.visualize_board
  end

  # Temporary main method for initial debug
  def main
    visualize_board
    
    puts "#{@current_player.color}, enter your move:"
    turn_complete = false
    until turn_complete
      turn_complete = interpret_command(@current_player.input)
    end

    visualize_board
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
  end

  # ----------------------------------------
  # --------  Move request methods  --------
  # ----------------------------------------

  def request_command(piece, disambig, capture, target_addr, promo)
    if capture == "x"
      request_capture(piece, disambig, target_addr, promo)
    else
      request_move(piece, disambig, target_addr, promo)
    end
  end

  def request_capture(piece, disambig, target_addr, promo)
    puts "TODO"
  end

  def request_move(piece, disambig, target_addr, promo)
    piece_name = piece_name(piece)

    piece_list = @board.find_pieces(piece_name, @current_player.color)
    piece_list.select! {|p| p.check_valid_move(@board, target_addr)}
    piece = disambiguate(piece_list, disambig)

    if piece.nil?
      puts "Error - no valid piece found"
      return false
    end

    @board.move_piece_to_address(piece, target_addr)
  end

  def disambiguate(list, disambig)
    puts "TODO - disambiguate method"
    list[0]
  end

  def piece_name(piece)
    case piece
    when ''
      'Pawn'
    when 'N'
      'Knight'
    when 'R'
      'Rook'
    when 'B'
      'Bishop'
    when 'Q'
      'Queen'
    when 'K'
      'King'
    end
  end

  def queenside_castle_request
    puts "TODO"
  end

  def kingside_castle_request
    puts "TODO"
  end
end

