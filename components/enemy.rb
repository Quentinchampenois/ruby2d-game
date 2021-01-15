# Background stars
class Enemy
  def initialize(x:, y:)
    @y_velocity = rand(-5..-1)
    @shape = Rectangle.new(
            x: x, y: y,
            width: rand(100..250), height: 15,
            color: 'teal',
        )

  end

  def move
    @shape.y = (@shape.y - @y_velocity) % Window.height
  end
end
