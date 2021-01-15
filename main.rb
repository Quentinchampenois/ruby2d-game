# frozen_string_literal: true

require 'ruby2d'

require_relative './ui_component'
require_relative './components/ui_component_text'
require_relative './player'
require_relative './components/star'

set background: 'navy'
# set fps_cap: 20

# Define grid
SQUARE_SIZE = 30
GRID_WIDTH = Window.width / SQUARE_SIZE
GRID_HEIGHT = Window.height / SQUARE_SIZE

# GameSelector class allows to create a game menu
class GameSelector
  attr_reader :ui_component

  def initialize(ui_component)
    @ui_component = ui_component
    @stars = Array.new(100).map { Star.new }

    lazy_register 'Fast runner'
  end

  def update
    #@stars.each { |star| star.move } if Window.frames.even?
  end

  def begin
    lazy_register("Let's play") do
      @ui_component.ui_elements.first.remove
    end
  end

  private

  def lazy_register(str, &block)
    yield if block_given?
    @ui_component.lazy_register do
      text = Text.new(str, size: 72, y: 40)
      text.x = (Window.width - text.width) / 2
      text
    end
  end
end

ui_component = UiComponentText.new
game = GameSelector.new(ui_component)

update do
  game.update
end

on :key_down do |event|
  puts event.key
  case event.key
  when 'space'
    game.begin
  when 'right'
    game.move(:right)
  end
end

show
