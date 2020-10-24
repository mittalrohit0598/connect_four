# frozen_string_literal: true

require './lib/connect_four/game'

describe Game do
  let(:game) { Game.new(%w[player1 player2]) }
  describe '#initialize' do
    it 'when arguments are absent' do
      expect { Game.new }.to raise_error ArgumentError
    end
    it 'when arguments are present' do
      expect { game }.to_not raise_error
    end
  end
  describe '#switch_players' do
    it 'swaps current_player and other_player' do
      players = game.current_player, game.other_player
      game.send(:switch_players)
      expect([game.other_player, game.current_player]).to eq(players)
    end
  end
  describe '#move' do
    let(:x) { Cell.new('X') }
    let(:empty) { Cell.new("\u25cb") }
    let(:board) do
      Board.new([
                  [x, empty, empty, empty, empty, empty, empty],
                  [x, empty, empty, empty, empty, empty, empty],
                  [x, empty, empty, empty, empty, empty, empty],
                  [x, empty, empty, empty, empty, empty, empty],
                  [x, empty, empty, empty, empty, empty, empty],
                  [x, empty, empty, empty, empty, empty, empty]
                ])
    end
    let(:game) { Game.new(%w[player1 player2], board) }
    it 'returns valid move' do
      allow(game).to receive(:solicit_move)
      allow(game).to receive(:gets).and_return('5')
      move = game.send(:move)
      expect(move).to eq(4)
    end
    it 'run loop untill a valid move is entered' do
      allow(game).to receive(:solicit_move)
      allow(game).to receive(:gets).and_return('8')
      allow(game).to receive(:puts)
      allow(game).to receive(:gets).and_return('7')
      move = game.send(:move)
      expect(move).to eq(6)
    end
    it 'run loop untill a valid move is entered and the respective column is not full' do
      allow(game).to receive(:solicit_move)
      allow(game).to receive(:gets).and_return('1')
      allow(game).to receive(:puts)
      allow(game).to receive(:gets).and_return('2')
      move = game.send(:move)
      expect(move).to eq(1)
    end
  end
end
