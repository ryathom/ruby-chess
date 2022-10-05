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
end