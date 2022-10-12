class Player
  attr_reader :color, :name

  def initialize(color)
    @color = color
    @name = color.capitalize
  end

  NOTATION = /([Oo0](-[Oo0]){1,2}|[KQRBN]?[a-h]?[1-8]?x?[a-h][1-8](=[QRBN])?[+#]?)/

  def white?
    return true if @color == 'white'

    false
  end

  def black?
    return true if @color == 'black'

    false
  end

  def enemy
    return 'white' if black?
    return 'black' if white?
  end

  def input
    loop do
      input = gets.chomp
      input = verify_input(input)
      return input unless input.nil?

      puts 'Input Error: Enter valid chess notation. #TODO: Man page/help'
    end
  end

  def verify_input(input)
    return input if input == 'save'

    return input if input.match(NOTATION)

    nil
  end
end