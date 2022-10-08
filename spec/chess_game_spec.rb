require_relative '../lib/chess_game'

describe ChessGame do
  subject(:game) { described_class.new }

  describe '#castling?' do
    it 'accepts kingside castling' do
      move = '0-0'
      expect(game.castling?(move)).to be true
    end

    it 'accepts queenside castling' do
      move = 'O-O-O'
      expect(game.castling?(move)).to be true
    end

    it 'rejects other moves' do
      move = 'Ke6'
      expect(game.castling?(move)).to be false
    end
  end

  describe '#queenside?' do
    it 'accepts queenside castling' do
      move = '0-0-0'
      expect(game.queenside?(move)).to be true
    end

    it 'rejects kingside castling' do
      move = '0-0'
      expect(game.queenside?(move)).to be false
    end
  end

  describe '#split_disambig' do
    it 'splits d3' do
      input = 'd3'
      expect(game.split_disambig(input)).to eql(['d', '3'])
    end

    it 'splits 3' do
      input = '3'
      expect(game.split_disambig(input)).to eql(['', '3'])
    end
  end

end