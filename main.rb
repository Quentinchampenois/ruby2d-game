# frozen_string_literal: true

require 'ruby2d'

require_relative './ui_component'
require_relative './components/enemy'
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
  attr_reader :stars

  def initialize(ui_component)
    @ui_component = ui_component
    @stars = Array.new(100).map { Star.new }

    @ui_component.lazy_register do
      text = Text.new("Fast runner", size: 72, y: 40)
      text.x = (Window.width - text.width) / 2
      text
    end
  end

  def update
    #@stars.each { |star| star.move } if Window.frames.even?
  end

  def begin
    @ui_component.ui_elements.first.remove
  end
end

ui_component = UiComponentText.new
game = GameSelector.new(ui_component)
player = Player.new(SQUARE_SIZE)
player.shape.remove

enemy = Enemy.new(x: 15, y: 5)
enemy2 = Enemy.new(x: 300, y: 20)

has_begun = false
update do
  game.update
  if Window.frames % 2 == 0
    game.stars.each(&:move)
  end

  if Window.frames % 1 == 0
    enemy.move
    enemy2.move
  end
end

on :key_down do |event|
  puts event.key
  case event.key
  when 'space'
    unless has_begun
      game.begin unless has_begun
      player.shape.add
      has_begun = true
    end
  when 'right'
    player.shape.x += 10 if has_begun
  end
end


on :key_held do |event|
  case event.key
  when 'right'
    if has_begun
      if player.shape.x + 10 >= Window.width + SQUARE_SIZE
        player.shape.x = 0 + SQUARE_SIZE
      else
        player.shape.x += 10
      end
    end
  when 'left'
    if has_begun
      if player.shape.x - 10 <= 0 - SQUARE_SIZE
        player.shape.x = Window.width - SQUARE_SIZE
      else
        player.shape.x -= 10
      end
    end
  end
end
show
