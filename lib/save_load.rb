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

  def prompt_filename
    puts "Choose a file name for your saved game: "
    input = gets.chomp

  end
end