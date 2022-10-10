# frozen_string_literal: true

require_relative 'chess_piece'

class ChessBoard
  def initialize
    @board = Array.new(8) { Array.new(8, nil) }
    initial_setup
  end

  def visualize_board
    puts nil

    @board.each_with_index do |row, idx|
      n = 8 - idx
      string = " #{n} | "
      row.each do |space|
        string += if space.nil?
                    '_'
                  else
                    space.symbol
                  end
        string += ' | '
      end
      puts string
    end

    puts '     a   b   c   d   e   f   g   h'
    puts nil
  end

  # ----------------------------------------
  # -----------  Set up methods  -----------
  # ----------------------------------------

  def initial_setup
    @board[0] = setup_non_pawns('black')
    @board[1] = setup_pawns('black')

    @board[6] = setup_pawns('white')
    @board[7] = setup_non_pawns('white')
  end

  def setup_pawns(color)
    Array.new(8) { Pawn.new(color, self) }
  end

  def setup_non_pawns(color)
    row = []

    row << Rook.new(color, self)
    row << Knight.new(color, self)
    row << Bishop.new(color, self)
    row << Queen.new(color, self)
    row << King.new(color, self)
    row << Bishop.new(color, self)
    row << Knight.new(color, self)
    row << Rook.new(color, self)

    row
  end

  # ----------------------------------------
  # ------- Find and move methods ----------
  # ----------------------------------------

  FILEREF = %w[a b c d e f g h].freeze

  def lookup(address)
    address = address.split('')
    file = address[0] # letter
    rank = address[1] # number

    file = FILEREF.index(file)
    rank = 8 - rank.to_i

    [rank, file]
  end

  def encode(location)
    file = location[1]
    rank = location[0]

    file = FILEREF[file]
    rank = 8 - rank

    addr = file.to_s + rank.to_s
  end

  def within_bounds(pointer)
    pointer[0].between?(0,7) && pointer[1].between?(0,7)
  end

  def find_pieces(type, color)
    @board.flatten.select do |piece|
      piece && (piece.class.name == type) && (piece.color == color)
    end
  end

  def find_all_pieces(color)
    @board.flatten.select do |piece|
      piece && (piece.color == color)
    end
  end

  def get_piece_at_location(location)
    x = location[0]
    y = location[1]
    @board[x][y]
  end

  def get_piece_at_address(address)
    location = lookup(address)
    get_piece_at_location(location)
  end

  def get_location_of_piece(piece)
    @board.each_with_index do |row, i|
      row.each_with_index do |space, j|
        if space == piece
          return [i, j]
        end
      end
    end
    nil
  end

  def move_piece_to_location(piece, location)
    x = location[0]
    y = location[1]
    @board[x][y] = remove_piece(piece)
    piece.set_moved
  end

  def move_piece_to_address(piece, addr)
    location = lookup(addr)
    move_piece_to_location(piece, location)
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

  def remove_piece_at_location(location)
    piece = get_piece_at_location(location)
    remove_piece(piece)
  end

  def remove_piece_at_address(address)
    piece = get_piece_at_address(address)
    remove_piece(piece)
  end

  def check_for_en_passant(target_addr)
    location = lookup(target_addr)

    north = [location[0]-1, location[1]]
    south = [location[0]+1, location[1]]

    pieces = []

    pieces << get_piece_at_location(north) if within_bounds(north)
    pieces << get_piece_at_location(south) if within_bounds(south)

    pieces.compact.select { |p| p.en_passant_flag == true }
  end

  # ----------------------------------------
  # ------- Castling and check ----------
  # ----------------------------------------

  # returns list of pieces of given color attacking given square
  def square_attackers(addr, color)
    piece_list = find_all_pieces(color)

    piece_list.select! {|p| p.check_threat(addr)}
  end

  def square_is_under_attack(addr, color)
    return true unless square_attackers(addr, color).empty?
  end

  def queenside_castle(king, rook)
    king_location = get_location_of_piece(king)
    king_location[1] -= 2
    move_piece_to_location(king, king_location)

    rook_location = get_location_of_piece(rook)
    rook_location[1] += 3
    move_piece_to_location(rook, rook_location)
  end

  def kingside_castle(king, rook)
    king_location = get_location_of_piece(king)
    king_location[1] += 2
    move_piece_to_location(king, king_location)

    rook_location = get_location_of_piece(rook)
    rook_location[1] -= 2
    move_piece_to_location(rook, rook_location)
  end
    
end