class Player
  def initialize
    @shape = Square.new(x: (Window.width + SQUARE_SIZE)/2, y: (Window.height+ SQUARE_SIZE)/2, size: SQUARE_SIZE - 1, color: 'white')
  end
end
