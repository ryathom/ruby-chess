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

  describe '#capture?' do
    it 'accepts a capturing move' do
      move = 'Kxe6'
      expect(game.capture?(move)).to be true
    end

    it 'rejects other moves' do
      move = 'Ke6'
      expect(game.capture?(move)).to be false
    end
  end

  describe '#pawn?' do
    it 'accepts a pawn move' do
      move = 'a6'
      expect(game.pawn?(move)).to be true
    end

    it 'accepts a pawn capture' do
      move = 'xe4'
      expect(game.pawn?(move)).to be true
    end

    it 'accepts a promotion' do
      move = 'e8Q'
      expect(game.pawn?(move)).to be true
    end

    it 'rejects a knight move' do
      move = 'Ke6'
      expect(game.pawn?(move)).to be false
    end
  end

  describe '#pawn_promo?' do
    it 'accepts a pawn promo move' do
      move = 'a6Q'
      expect(game.pawn_promo?(move)).to be true
    end

    it 'rejects a pawn move' do
      move = 'a6'
      expect(game.pawn_promo?(move)).to be false
    end
  end
end