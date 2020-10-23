# frozen_string_literal: true

# class Board
class Board
  attr_reader :grid
  def initialize(grid = default_grid)
    @grid = grid
  end

  def set_value(row, column, value)
    get_value(row, column).value = value
  end

  def get_value(row, column)
    grid[row][column]
  end

  def print_grid
    grid.each do |arr|
      arr.each do |cell|
        print cell.value + ' '
      end
      puts
    end
  end

  def winner?
    horizontal_check?(grid) || vertical_check? || diagonal_up_check? || diagonal_down_check?
  end

  def draw?
    grid.flatten.map(&:value).all? { |n| n != '_' }
  end

  private

  def default_grid
    Array.new(6) { Array.new(7) { Cell.new } }
  end

  def horizontal_check?(grid)
    grid.each_index do |i|
      grid[i][0, 4].each_index do |j|
        return true if grid[i][j, 4].map(&:value).all? { |n| n == grid[i][j].value } && grid[i][j].value != "\u25cb"
      end
    end
    false
  end

  def vertical_check?
    horizontal_check?(grid.transpose)
  end

  def diagonal_down_check?
    grid[0...grid.length - 2].each_with_index do |arr, i|
      arr.each_index do |j|
        diagonal_array = []
        3.times do |k|
          diagonal_array << grid[i + k][j + k]&.value
        end
        return true if diagonal_array.all? { |n| n == diagonal_array[0] } && diagonal_array[i] != "\u25cb"
      end
    end
    false
  end

  def diagonal_up_check?
    (2...grid.length).reverse_each do |i|
      grid[i].each_index do |j|
        diagonal_array = []
        3.times do |k|
          diagonal_array << grid[i - k][j + k]&.value
        end
        return true if diagonal_array.all? { |n| n == diagonal_array[0] } && diagonal_array[i] != "\u25cb"
      end
    end
    false
  end
end
