require_relative '../lib/player'

describe Player do
  subject(:player) { described_class.new('white') }

  describe '#verify_input' do
    it 'accepts valid notation - knight move' do
      notation = 'Nc6'
      expect(player.verify_input(notation)).to eql(notation)
    end

    it 'accepts valud notation - bishop capture' do
      notation = 'Bxd5'
      expect(player.verify_input(notation)).to eql(notation)
    end

    it 'accepts valud notation - castling' do
      notation = '0-0-0'
      expect(player.verify_input(notation)).to eql(notation)
    end

    it 'rejects incorrect case' do
      notation = 'nC6'
      expect(player.verify_input(notation)).to eql(nil)
    end

    it 'rejects invalid space' do
      notation = 'Be9'
      expect(player.verify_input(notation)).to eql(nil)
    end

    it 'rejects no letters' do
      notation = '65'
      expect(player.verify_input(notation)).to eql(nil)
    end
  end
end
