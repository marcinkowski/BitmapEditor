require 'colorize'

class ColourDisplay
  COLOURS = {
      'O' => :black,   'Q'=> :light_black,
      'W' => :white,   'V'=> :light_white,
      'R' => :red,     'P'=> :light_red,
      'B' => :blue,    'S'=> :light_blue,
      'C' => :cyan,    'D'=> :light_cyan,
      'Y' => :yellow,  'I'=> :light_yellow,
      'G' => :green,   'T'=> :light_green,
      'M' => :magenta, 'N'=> :light_magenta,
  }

  def initialize(matrix)
    @matrix = matrix
  end

  def display
    result = ''

    1.upto(@matrix.height) do |y|
      1.upto(@matrix.width) do |x|
        key = @matrix.bitmap.key?([x,y]) ? @matrix.bitmap[[x,y]] : @matrix.background
        result += '  '.colorize(background: COLOURS.key?(key) ? COLOURS[key] : :default)
      end

      result += "\n"
    end

    result
  end
end