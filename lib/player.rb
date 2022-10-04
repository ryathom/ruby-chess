class Player
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
end