class CommandInterpreter
  def initialize(matrix, displays={})
    @matrix = matrix
    @displays = displays
  end

  def interpret(command)
    case command
      when /^L ([1-9][0-9]*) ([1-9][0-9]*) ([A-Z])$/
        @matrix.colours_pixel($1.to_i, $2.to_i, $3)
      when /^F ([1-9][0-9]*) ([1-9][0-9]*) ([A-Z])$/
        @matrix.fill($1.to_i, $2.to_i, $3)
      when /^V ([1-9][0-9]*) ([1-9][0-9]*) ([1-9][0-9]*) ([A-Z])$/
        @matrix.draw_vertical_segment($1.to_i, $2.to_i, $3.to_i, $4)
      when /^H ([1-9][0-9]*) ([1-9][0-9]*) ([1-9][0-9]*) ([A-Z])$/
        @matrix.draw_horizontal_segment($3.to_i, $1.to_i, $2.to_i, $4)
      when 'C'
        @matrix.clear
      else
        @displays.key?(command) ? @displays[command].display : false
    end
  end
end