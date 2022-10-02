# frozen_string_literal: true

class ChessPiece
  def initialize(color)
    @color = color
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

  def symbol
    return 'W' if white?
    return 'B' if black?
  end
end
