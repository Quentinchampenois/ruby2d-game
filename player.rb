class Player
  attr_accessor :shape

  def initialize(square_size)
    @shape = Image.new(
        'components/ship_1.png',
        x: (Window.width + square_size) / 2, y: (Window.height + square_size) - 150,
        width: 100, height: 100
    )

  end
end
