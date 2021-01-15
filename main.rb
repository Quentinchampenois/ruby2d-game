# frozen_string_literal: true

require 'ruby2d'
require 'ui_component'
require 'player'
require 'components/star'

set background: 'navy'
# set fps_cap: 20
#

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

    @ui_component.add(Text.new('Fast runner', size: 72, y: 40), :text)
    @ui_component.last_text.x = (Window.width - @ui_component.last_text.width) / 2

    @ui_component.add(Text.new("Press 'spacebar'", size: 32, y: 120), :text)
    @ui_component.last_text.x = (Window.width - @ui_component.last_text.width) / 2
  end

  def update
    if Window.frames % 2 == 0
      @stars.each { |star| star.move }
    end
  end

  def begin
    @ui_component.drop_text
    @ui_component.add(Text.new("Let's play !", size: 72, y: 40), :text)
    @ui_component.last_text.x = (Window.width - @ui_component.last_text.width) / 2
  end
end

ui_component = UiComponent.new
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
