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

  def begin
    @ui_component.ui_elements.first.remove
  end
end

ui_component = UiComponentText.new
game = GameSelector.new(ui_component)
player = Player.new(SQUARE_SIZE)
player.shape.remove
score = 0
enemies = [
    Enemy.new(x: 15, y: 5),
    Enemy.new(x: 300, y: 20),
    Enemy.new(x: 200, y: -15),
]
enemies.each do |eny|
  eny.shape.remove
end

has_begun = false
update do
  if Window.frames % 2 == 0
    game.stars.each(&:move)
  end

  if has_begun
    enemies.each do |enemy|
      if enemy.shape.y >= Window.height
        enemy.reset
        game.ui_component.update!(:text, "Score : #{score}", "Score : #{score + 1}")
        score += 1
      end

      enemy.move
    end
  end
end

on :key_down do |event|
  case event.key
  when 'space'
    unless has_begun
      game.begin unless has_begun
      game.ui_component.register(Text.new("Score : #{score}", size: 24, x: 10, y: 10, z: 4))
      player.shape.add
      enemies.each do |eny|
        eny.shape.add
      end
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
