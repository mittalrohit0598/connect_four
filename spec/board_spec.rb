# frozen_string_literal: true

require './lib/connect_four/board'

describe Board do
  let(:x) { Cell.new('X') }
  let(:y) { Cell.new('O') }
  let(:empty) { Cell.new("\u25cb") }

  describe '#initialize' do
    it 'when argument is given' do
      expect { Board.new(grid: 'grid') }.to_not raise_error
    end
    it 'when argument is not given' do
      expect { Board.new }.to_not raise_error
    end
  end
  describe '#default_board' do
    it 'sets the grid with three rows by default' do
      board = Board.new
      expect(board.grid.size).to eq(6)
    end
    it 'creates the rows with three things by default' do
      board = Board.new
      board.grid.each do |row|
        expect(row.size).to eq(7)
      end
    end
  end
  describe '#grid' do
    it 'returns grid' do
      board = Board.new('abc')
      expect(board.grid).to eq('abc')
    end
  end
  describe '#get_value' do
    it 'returns value from given (x, y) co-ordinate' do
      board = Board.new([['', '', ''], ['', '', 'X'], ['', '', '']])
      expect(board.get_value(1, 2)).to eq('X')
    end
  end
  describe '#set_value' do
    let(:empty) { Cell.new("\u25cb") }
    it 'set the given value on deepest row in given column' do
      board = Board.new([
                          [empty, empty, empty],
                          [empty, empty, empty],
                          [empty, empty, empty],
                          [empty, empty, empty],
                          [empty, empty, empty],
                          [empty, empty, empty]
                        ])
      board.set_value(2, 'xyz')
      expect(board.get_value(2, 2).value).to eq('xyz')
    end
  end
  describe '#winner?' do
    it 'returns true when horizontal_check? is true' do
      board = Board.new
      allow(board).to receive_messages(horizontal_check?: true)
      expect(board.winner?).to eq(true)
    end
    it 'returns true when vertical_check? is true' do
      board = Board.new
      allow(board).to receive_messages(vertical_check?: true)
      expect(board.winner?).to eq(true)
    end
    it 'returns true when diagonal_up_check? is true' do
      board = Board.new
      allow(board).to receive_messages(diagonal_up_check?: true)
      expect(board.winner?).to eq(true)
    end
    it 'returns true when diagonal_down_check? is true' do
      board = Board.new
      allow(board).to receive_messages(diagonal_up_check?: true)
      expect(board.winner?).to eq(true)
    end
    it 'returns true when a diagonal from top left to bottom right contains the same 4 colors together' do
      board = Board.new([
                          [empty, empty, empty, empty, empty, empty, empty],
                          [empty, empty, empty, empty, empty, empty, empty],
                          [empty, x, empty, empty, empty, empty, empty],
                          [empty, empty, x, empty, empty, empty, empty],
                          [empty, empty, empty, x, empty, empty, empty],
                          [empty, empty, empty, empty, x, empty, empty]
                        ])
      expect(board.winner?).to eq(true)
    end
    it 'returns true when a diagonal from top left to bottom right contains the same 4 colors together' do
      board = Board.new([
                          [empty, empty, empty, x, empty, empty, empty],
                          [empty, empty, x, empty, empty, empty, empty],
                          [empty, x, empty, empty, empty, empty, empty],
                          [x, empty, empty, empty, empty, empty, empty],
                          [empty, empty, empty, empty, empty, empty, empty],
                          [empty, empty, empty, empty, empty, empty, empty]
                        ])
      expect(board.winner?).to eq(true)
    end
    it 'returns true when a row contains the same 4 colors together' do
      board = Board.new([
                          [empty, empty, empty, empty, empty, empty, empty],
                          [empty, empty, empty, empty, empty, empty, empty],
                          [empty, x, x, x, x, empty, empty],
                          [empty, empty, empty, empty, empty, empty, empty],
                          [empty, empty, empty, empty, empty, empty, empty],
                          [empty, empty, empty, empty, empty, empty, empty]
                        ])
      expect(board.winner?).to eq(true)
    end
    it 'returns true when a diagonal from top left to bottom right contains the same 4 colors together' do
      board = Board.new([
                          [empty, empty, empty, empty, empty, empty, empty],
                          [empty, empty, empty, empty, empty, empty, empty],
                          [empty, x, empty, empty, empty, empty, empty],
                          [empty, x, empty, empty, empty, empty, empty],
                          [empty, x, empty, empty, empty, empty, empty],
                          [empty, x, empty, empty, empty, empty, empty]
                        ])
      expect(board.winner?).to eq(true)
    end
  end
  describe '#full_column?' do
    it 'returns true if column is full' do
      board = Board.new([
                          [empty, empty, x, empty, empty, empty, empty],
                          [empty, empty, x, empty, empty, empty, empty],
                          [empty, empty, x, empty, empty, empty, empty],
                          [empty, empty, x, empty, empty, empty, empty],
                          [empty, empty, x, empty, empty, empty, empty],
                          [empty, empty, x, empty, empty, empty, empty]
                        ])
      expect(board.full_column?(2)).to eq(true)
    end
    it 'returns false if column is not full' do
      board = Board.new([
                          [empty, empty, x, empty, empty, empty, empty],
                          [empty, empty, x, empty, empty, empty, empty],
                          [empty, empty, x, empty, empty, empty, empty],
                          [empty, empty, x, empty, empty, empty, empty],
                          [empty, empty, x, empty, empty, empty, empty],
                          [empty, empty, x, empty, empty, empty, empty]
                        ])
      expect(board.full_column?(3)).to eq(false)
    end
  end
end
