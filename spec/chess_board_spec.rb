require_relative '../lib/chess_board'

describe ChessBoard do
  subject(:chessboard) { described_class.new }

  describe '#get_piece' do
    it 'returns a black pawn' do
      piece = chessboard.get_piece(1,0)
      expect(piece.black?).to be true
      expect(piece).to be_a(Pawn)
    end

    it 'returns a white king' do
      piece = chessboard.get_piece(7,4)
      expect(piece.white?).to be true
      expect(piece).to be_a(King)
    end

    it 'returns nil' do
      piece = chessboard.get_piece(3,3)
      expect(piece).to be nil
    end
  end

  describe '#remove_piece' do
    it 'removes the piece' do
      piece = chessboard.get_piece(1,0)
      chessboard.remove_piece(piece)

      expect(chessboard.get_piece(1,0)).to be nil
    end
  end


  describe '#move_piece' do
    context 'when a black pawn is moved' do
      
      before do
        pawn = chessboard.get_piece(1, 0)
        chessboard.move_piece(pawn, 2, 0)
      end

      it 'piece is now in new space' do
        new_space = chessboard.get_piece(2, 0)
        expect(new_space).to be_a(Pawn)
      end

      it 'previous space is empty' do
        new_space = chessboard.get_piece(1, 0)
        expect(new_space.nil?).to be true
      end

      it 'piece is still black' do
        board = chessboard.instance_variable_get(:@board)
        expect(board[2][0].black?).to be true
      end
    end
  end
end