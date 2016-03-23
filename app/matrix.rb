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

  def colour_pixel(x, y, colour)
    valid_x?(x)
    valid_y?(y)
    valid_colour?(colour)

    @bitmap[[x, y]] = colour
  end

  def draw_vertical_segment(x, y_start, y_end, colour)
    valid_x?(x)
    valid_y?(y_start)
    valid_y?(y_end)
    valid_colour?(colour)

    (y_start..y_end).each do |y|
      @bitmap[[x, y]] = colour
    end
  end

  def draw_horizontal_segment(y, x_start, x_end, colour)
    valid_y?(y)
    valid_x?(x_start)
    valid_x?(x_end)
    valid_colour?(colour)

    (x_start..x_end).each do |x|
      @bitmap[[x, y]] = colour
    end
  end

  def clear
    @bitmap.clear
  end

  def fill(x, y, colour)
    valid_x?(x)
    valid_y?(y)
    valid_colour?(colour)

    old_colour = @bitmap[[x, y]]
    colour_pixel(x, y, colour)

    cross_pixels(x, y).each do |coordinates|
      if old_colour == @bitmap[[coordinates[0], coordinates[1]]]
        fill(coordinates[0], coordinates[1], colour)
      end
    end
  end

  def draw_rectangle(x_start, x_end, y_start, y_end, colour)
    x_start, x_end = [x_start, x_end].sort
    y_start, y_end = [y_start, y_end].sort

    draw_horizontal_segment(y_start, x_start, x_end, colour)
    draw_horizontal_segment(y_end, x_start, x_end, colour)
    draw_vertical_segment(x_start, y_start, y_end, colour)
    draw_vertical_segment(x_end, y_start, y_end, colour)
  end

  private

  def cross_pixels(x, y)
    [[x, y-1], [x, y+1], [x+1, y], [x-1, y]].select do |value|
      pixel_exists? value[0], value[1]
    end
  end

  def pixel_exists?(x, y)
    x <= @width && x >= 1 && y <= @height && y >= 1
  end

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