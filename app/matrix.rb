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

  private

  def valid_width?(width)
    raise ArgumentError.new("The width can't exceed #{MAX_WIDTH}.") if width > MAX_WIDTH
  end

  def valid_height?(height)
    raise ArgumentError.new("The height can't exceed #{MAX_HEIGHT}.") if height > MAX_HEIGHT
  end

  def valid_colour?(colour)
    raise ArgumentError.new("Wrong colour '#{colour.to_s}'.") if colour.size != 1
  end
end