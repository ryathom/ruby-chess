# frozen_string_literal: true

require_relative 'chess_board'
require_relative 'player'
require_relative 'save_load'

CASTLING = /(([Oo0](-[Oo0]){1,2}))/
QUEENSIDE = /(([Oo0](-[Oo0]){2}))/

SPLIT_COMMAND = /([KQRBN]?)([a-h]?[1-8]?)(x?)([a-h][1-8])([QRBN]?)/
SPLIT_DISAMBIG = /([a-h]?)([1-8]?)/

class ChessGame
  include SaveLoad

  def initialize
    new_or_load_game
    @players = [Player.new('white'), Player.new('black')]
    @current_player = @players[0]
  end

  def visualize_board
    # system 'clear'
    @board.visualize_board
  end

  def new_or_load_game
    input = 0
    until [1, 2].include?(input)
      puts "Press 1 to start a new game or 2 to load a saved game:"
      input = gets.chomp.to_i
    end

    case input
    when 1
      @board = ChessBoard.new()
      @players = [Player.new('white'), Player.new('black')]
      @current_player = @players[0]
    when 2
      @board = load_game
      @players = @board.save_players
      @current_player = @board.save_current_player
    end
  end

  # Temporary main method for initial debug
  def main
    visualize_board
    
    loop do
      announce_check
      clear_en_passant_flags
      puts "#{@current_player.name}, enter your move:"
      turn_complete = false
      until turn_complete
        turn_complete = interpret_command(@current_player.input)
      end

      visualize_board
      next_player
    end
  end

  def next_player
    if @current_player == @players[0]
      @current_player = @players[1]
    else
      @current_player = @players[0]
    end
  end

  def announce_check
    king = @board.find_pieces('King', @current_player.color)[0]
    if king.check?
      puts "#{@current_player.name}, you are in check."
    end
  end

  def clear_en_passant_flags
    pawns = @board.find_pieces('Pawn', @current_player.color)
    pawns.each { |p| p.clear_en_passant_flag }
  end

  # ----------------------------------------
  # ---  Command interpretation methods  ---
  # ----------------------------------------
  def interpret_command(input)
    if save?(input)
      @board.save_players = @players
      @board.save_current_player = @current_player
      save_game(@board)
    elsif castling?(input)
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

  def save?(input)
    return true if input == 'save'

    false
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

  def split_disambig(input)
    obj = input.scan(SPLIT_DISAMBIG)[0]
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
    return false unless check_for_enemy_piece(target_addr)

    piece_name = piece_name(piece)

    piece_list = @board.find_pieces(piece_name, @current_player.color)
    piece_list.select! {|p| p.check_valid_capture(target_addr)}
    
    general_request(piece_list, disambig, target_addr, promo)
  end

  def request_move(piece, disambig, target_addr, promo)
    unless @board.get_piece_at_address(target_addr).nil?
      puts "Error - space is not empty. Capture commands must include 'x'"
      return false
    end

    piece_name = piece_name(piece)

    piece_list = @board.find_pieces(piece_name, @current_player.color)
    piece_list.select! {|p| p.check_valid_move(target_addr)}

    general_request(piece_list, disambig, target_addr, promo)
  end

  def general_request(piece_list, disambig, target_addr, promo)
    return false unless piece = disambiguate(piece_list, disambig)

    if piece.nil?
      puts "Error - no valid piece found to make this move"
      return false
    end

    if promo != ""
      if request_promo(piece, target_addr, promo)
        @board.move_piece_to_address(piece, target_addr)
        promote(target_addr, promo)
      else
        return false
      end
    else
      @board.move_piece_to_address(piece, target_addr)
    end
  end

  def request_promo(piece, target_addr, promo)
    rank = @board.lookup(target_addr)[0]

    unless [0, 7].include?(rank)
      puts "Error - can only promote on end rank"
      return false
    end

    unless piece.class.name == 'Pawn'
      puts "Error - can only promote pawns"
      return false
    end

    true
  end

  def promote(target_addr, promo)
    name = piece_name(promo)
    piece = Object.const_get(name).new(@current_player.color, @board)
    
    @board.instantiate_at_addr(piece, target_addr)
  end

  def disambiguate(list, disambig)
    return list[0] if list.length == 1
    
    disambig = split_disambig(disambig)

    list.select! do |p|
      location = @board.get_location_of_piece(p)
      location = @board.encode(location).split('')

      (location[0] == disambig[0]) || (location[1] == disambig[1])
    end

    return list[0] if list.length == 1

    list.select! do |p|
      location = @board.get_location_of_piece(p)
      location = @board.encode(location).split('')

      (location[0] == disambig[0]) && (location[1] == disambig[1])
    end

    return list[0] if list.length == 1

    if list.length > 1
      puts "Error - multiple valid pieces found, please disambiguate"
    else
      puts "Error - no valid pieces found"
    end
    return false
  end

  def check_for_enemy_piece(target_addr)
    return true if @board.check_for_en_passant(target_addr)

    target = @board.get_piece_at_address(target_addr)

    if target.nil?
      puts "Error - no piece found to capture"
      return false
    end

    if target.color == @current_player.color
      puts "Error - you can't capture friendly pieces"
      return false
    end

    true
  end

  # REVISIT - can turn this into a dictionary/map
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
    king = king_can_castle
    rook = rook_can_castle(0)

    if (rook.nil? || king.nil?)
      puts "Queenside castle not possible"
      return false
    end

    if @current_player.white?
      spaces = ['c1', 'd1']
    else
      spaces = ['c8', 'd8']
    end
    
    spaces.each { |s| return false if @board.square_is_under_attack(s, @current_player.enemy) }

    if @current_player.white?
      spaces << 'b1'
    else
      spaces << 'b8'
    end

    spaces.each do |s|
      return false unless @board.get_piece_at_address(s).nil?
    end

    @board.queenside_castle(king, rook)
  end

  def kingside_castle_request
    king = king_can_castle
    rook = rook_can_castle(7)

    if (rook.nil? || king.nil?)
      puts "Kingside castle not possible"
      return false
    end

    if @current_player.white?
      spaces = ['f1', 'g1']
    else
      spaces = ['f8', 'g8']
    end

    spaces.each do |s|
      return false unless @board.get_piece_at_address(s).nil?
      return false if @board.square_is_under_attack(s, @current_player.enemy)
    end

    @board.kingside_castle(king, rook)
  end

  def king_can_castle
    king = @board.find_pieces('King', @current_player.color)
    king.select! { |k| !k.moved?}
    king.select! { |k| !k.check?}

    return king[0]
  end

  def rook_can_castle(file)
    rook = @board.find_pieces('Rook', @current_player.color)

    rook.select! { |r| @board.get_location_of_piece(r)[1] == file}
    rook.select! { |r| !r.moved? }

    return rook[0]
  end
end

