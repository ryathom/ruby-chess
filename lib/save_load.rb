# frozen_string_literal: true

require 'fileutils'

module SaveLoad
  def save_game(board)
    serialized_board = Marshal.dump(board)
    
    filename = prompt_filename

    dirname = "saves"
    FileUtils.mkdir_p(dirname) unless File.directory?(dirname)

    save = File.new("#{dirname}/#{filename}.txt", 'w')
    save.puts(serialized_board)
    save.close
  end

  def load_game
    puts Dir.entries("saves")
    puts nil
    puts "Enter the name of the file to load:"
    input = gets.chomp

    load_game = File.open("saves/#{input}")
    data = load_game.read
    Marshal.load(data)
  end

  def prompt_filename
    puts "Choose a file name for your saved game: "
    input = gets.chomp

  end
end