# frozen_string_literal: true

require './lib/connect_four/cell'

describe Cell do
  describe '#initialize' do
    it 'is initialized with a value of "_" by default' do
      cell = Cell.new
      expect(cell.value).to eq("\u25cb")
    end
    it 'can be initialized with a value of "X"' do
      cell = Cell.new('X')
      expect(cell.value).to eq('X')
    end
  end
end
