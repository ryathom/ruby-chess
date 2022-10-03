# frozen_string_literal: true

class ChessPiece
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
end

class Pawn < ChessPiece
  def symbol
    symbol = "\u2659" if white?
    symbol = "\u265F" if black?
    symbol.encode('utf-8')
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
