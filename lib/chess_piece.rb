# frozen_string_literal: true

class ChessPiece
  attr_reader :color

  def initialize(color)
    @color = color
    @moved = false
  end

  def white?
    return true if @color == 'white'

    false
  end

  def black?
    return true if @color == 'black'

    false
  end

  def piece?
    true
  end

  def set_moved
    @moved = true
  end

  def moved?
    @moved
  end

  def symbol
    return 'W' if white?
    return 'B' if black?
  end

  def diff_locations(own_location, target_location)
    diff = []
    diff << own_location[0] - target_location[0]
    diff << own_location[1] - target_location[1]
    diff
  end
end

class Pawn < ChessPiece
  def symbol
    symbol = "\u2659" if white?
    symbol = "\u265F" if black?
    symbol.encode('utf-8')
  end

  def check_valid_move(board, target_addr)
    target_location = board.lookup(target_addr)
    own_location = board.get_location_of_piece(self)
    diff = diff_locations(own_location, target_location)

    return false unless board.get_piece(target_location).nil? # empty square

    if moved?
      check_valid_single_move(diff)
    else
      check_valid_double_move(diff)
    end
  end

  def check_valid_single_move(diff)
    return diff == [1, 0] if white?
    return diff == [-1, 0] if black?
  end

  def check_valid_double_move(diff)
    return false if diff[1] != 0

    return diff[0].between?(1, 2) if white?
    return diff[0].between?(-2, -1) if black?
  end
end

class Knight < ChessPiece
  def symbol
    symbol = "\u2658" if white?
    symbol = "\u265E" if black?
    symbol.encode('utf-8')
  end
end

class Bishop < ChessPiece
  def symbol
    symbol = "\u2657" if white?
    symbol = "\u265D" if black?
    symbol.encode('utf-8')
  end
end

class Rook < ChessPiece
  def symbol
    symbol = "\u2656" if white?
    symbol = "\u265C" if black?
    symbol.encode('utf-8')
  end
end

class Queen < ChessPiece
  def symbol
    symbol = "\u2655" if white?
    symbol = "\u265B" if black?
    symbol.encode('utf-8')
  end
end

class King < ChessPiece
  def symbol
    symbol = "\u2654" if white?
    symbol = "\u265A" if black?
    symbol.encode('utf-8')
  end
end
