class Player
  def initialize(color)
    @color = color
  end

  NOTATION = /([Oo0](-[Oo0]){1,2}|[KQRBN]?[a-h]?[1-8]?x?[a-h][1-8](=[QRBN])?[+#]?)/
  CASTLING = /([Oo0](-[Oo0]){1,2})/
  SPLIT_MOVETEXT = /([KQRBN]?)([a-h]?)([1-8]?)(x?)([a-h][1-8])/

  def white?
    return true if @color == 'white'

    false
  end

  def black?
    return true if @color == 'black'

    false
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
    return input if input.match(NOTATION)

    nil
  end

  # seperates piece from target address
  def split_movetext(input)
    return input.scan(SPLIT_MOVETEXT)[0].reject {|e| e.empty?}
  end
end


# # Test
# player = Player.new('white')
# obj = player.split_movetext('Nc6')
# p obj

