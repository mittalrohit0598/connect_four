# frozen_string_literal: true

# class Cell
class Cell
  attr_accessor :value
  def initialize(value = "\u25cb")
    @value = value
  end
end
