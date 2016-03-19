class TextDisplay
  def initialize(matrix)
    @matrix = matrix
  end

  def display
    result = ''

    1.upto(@matrix.height) do |y|
      1.upto(@matrix.width) do |x|
        result += @matrix.bitmap.key?([x,y]) ? @matrix.bitmap[[x,y]] : @matrix.background
      end

      result += "\n"
    end

    result
  end
end