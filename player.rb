class Player
  attr_accessor :shape

  def initialize(square_size)
    @shape = Square.new(x: (Window.width + square_size) / 2, y: (Window.height + square_size) - 100, size: square_size - 1,
                        color: 'white')
  end
end
