class Matrix
  MAX_WIDTH = 250
  MAX_HEIGHT = 250

  attr_reader :width, :height, :bitmap, :background

  def initialize(width, height, background='O')
    valid_width?(width)
    valid_height?(height)
    valid_colour?(background)

    @width = width
    @height = height
    @bitmap = {}
    @background = background
  end

  def colours_pixel(x, y, colour)
    valid_x?(x)
    valid_y?(y)
    valid_colour?(colour)

    @bitmap[[x, y]] = colour
  end

  private

  def valid_x?(x)
    raise ArgumentError.new("Parameter X has to be between 1 and #{@width}.") if x > @width || x < 1
  end

  def valid_y?(y)
    raise ArgumentError.new("Parameter Y has to be between 1 and #{@height}.") if y > @height || y < 1
  end

  def valid_width?(width)
    raise ArgumentError.new("The width has to be between 1 and #{MAX_WIDTH}.") if width > MAX_WIDTH || width < 1
  end

  def valid_height?(height)
    raise ArgumentError.new("The height has to be between 1 and #{MAX_HEIGHT}.") if height > MAX_HEIGHT || height < 1
  end

  def valid_colour?(colour)
    raise ArgumentError.new("Wrong colour '#{colour.to_s}'.") if colour.size != 1
  end
end