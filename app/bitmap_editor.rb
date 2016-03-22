class BitmapEditor

  def run
    @running = true
    display_start_image
    puts 'type ? for help'
    while @running
      print '> '
      input = gets.chomp
      begin
        case input
          when '?'
            show_help
          when 'X'
            exit_console
          when /^I ([1-9][0-9]*) ([1-9][0-9]*)$/
            @command_interpreter = CommandInterpreter.new(Matrix.new(width, height), {
                'S' => TextDisplay.new(@matrix),
                'D' => ColourDisplay.new(@matrix)
            })
          else
            @command_interpreter ? command_interpreter.interpret(input) : error
        end
      rescue ArgumentError => e
        puts e.message
      end
    end
  end

  private

  def create_matrix(width, height)
    @matrix = Matrix.new(width, height)
  end

  def error
    puts 'Create an Image first.'
  end

  def exit_console
    puts 'goodbye!'
    @running = false
  end

  def display_start_image
    matrix = Matrix.new(33, 7)
    # Generate colorful background
    1.upto(matrix.width) do |x|
      1.upto(matrix.height) do |y|
        matrix.colours_pixel(x, y, ['S', 'B', 'C', 'M'].sample)
      end
    end

    # Letter "C"
    matrix.draw_vertical_segment(2, 3, 5, 'O')
    matrix.draw_horizontal_segment(2, 3, 4, 'O')
    matrix.draw_horizontal_segment(6, 3, 4 ,'O')
    matrix.colours_pixel(5, 3, 'O')
    matrix.colours_pixel(5, 5, 'O')
    # Letter "A"
    matrix.draw_vertical_segment(7, 3, 6, 'O')
    matrix.draw_vertical_segment(10, 3, 6, 'O')
    matrix.draw_horizontal_segment(5, 8, 9 ,'O')
    matrix.draw_horizontal_segment(2, 8, 9 ,'O')
    # Letter "R"
    matrix.draw_vertical_segment(12, 2, 6, 'O')
    matrix.draw_vertical_segment(15, 3, 4, 'O')
    matrix.draw_horizontal_segment(5, 13, 14 ,'O')
    matrix.draw_horizontal_segment(2, 13, 14 ,'O')
    matrix.colours_pixel(15, 6, 'O')
    # Letter "W"
    matrix.draw_vertical_segment(17, 2, 6, 'O')
    matrix.draw_vertical_segment(21, 2, 6, 'O')
    matrix.colours_pixel(18, 6, 'O')
    matrix.colours_pixel(19, 5, 'O')
    matrix.colours_pixel(20, 6, 'O')
    # Letter "O"
    matrix.draw_vertical_segment(23, 3, 5, 'O')
    matrix.draw_vertical_segment(26, 3, 5, 'O')
    matrix.draw_horizontal_segment(2, 24, 25 ,'O')
    matrix.draw_horizontal_segment(6, 24, 25 ,'O')
    # Letter "W"
    matrix.draw_vertical_segment(28, 2, 6, 'O')
    matrix.draw_vertical_segment(32, 2, 6, 'O')
    matrix.colours_pixel(29, 6, 'O')
    matrix.colours_pixel(30, 5, 'O')
    matrix.colours_pixel(31, 6, 'O')

    puts ColourDisplay.new(matrix).display
  end

  def show_help
    puts "? - Help
I M N - Create a new M x N image with all pixels coloured white (O).
C - Clears the table, setting all pixels to white (O).
L X Y C - Colours the pixel (X,Y) with colour C.
V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
F X Y C - Fill the region R with the colour C. R is defined as: Pixel (X,Y) belongs to R. Any other pixel which is the same colour as (X,Y) and shares a common side with any pixel in R also belongs to this region.
S - Show the contents of the current image
X - Terminate the session
COLOUR - Show the contents of the current image using colorful display"
  end
end
