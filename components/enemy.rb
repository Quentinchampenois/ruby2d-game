# Background stars
class Enemy
  attr_accessor :shape
  def initialize(x:, y:)
    @y_velocity = rand(-3..-1)
    @shape = Rectangle.new(
            x: x, y: y,
            width: rand(100..250), height: 15,
            color: 'teal',
        )

  end

  def move
    @shape.y = (@shape.y - @y_velocity) #% Window.height
  end

  def reset
    @y_velocity = rand(-5..-1)
    width = rand(100..250)
    @shape = Rectangle.new(
        x: rand(0.. Window.width - width), y: -15,
        width: width, height: 15,
        color: 'random',
        )
  end
end
