# Background stars
class Enemy
  attr_accessor :shape
  def initialize(x:, y:)
    reset
  end

  def move
    @shape.y = (@shape.y + @y_velocity) #% Window.height
  end

  def collision?(x:, y:)
    x >= @shape.x && x <= (@shape.x + @shape.width) && y >= @shape.y && y <= (@shape.y + @shape.height)
  end

  def reset
    @y_velocity = rand(1..8)
    width = rand(100..250)
    @shape = Rectangle.new(
        x: rand(0.. Window.width - width), y: -15,
        width: width, height: 15,
        color: 'random',
        )
  end
end
