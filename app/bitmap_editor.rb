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
            create_matrix($1.to_i, $2.to_i)
          when /^L ([1-9][0-9]*) ([1-9][0-9]*) ([A-Z])$/
            colour_pixel($1.to_i, $2.to_i, $3)
          when /^F ([1-9][0-9]*) ([1-9][0-9]*) ([A-Z])$/
            fill($1.to_i, $2.to_i, $3)
          when /^V ([1-9][0-9]*) ([1-9][0-9]*) ([1-9][0-9]*) ([A-Z])$/
            draw_vertical_segment($1.to_i, $2.to_i, $3.to_i, $4)
          when /^H ([1-9][0-9]*) ([1-9][0-9]*) ([1-9][0-9]*) ([A-Z])$/
            draw_horizontal_segment($3.to_i, $1.to_i, $2.to_i, $4)
          when /^R ([1-9][0-9]*) ([1-9][0-9]*) ([1-9][0-9]*) ([1-9][0-9]*) ([A-Z])$/
            draw_rectangle($1.to_i, $2.to_i, $3.to_i, $4.to_i, $4)
          when 'C'
            clear_matrix
          when 'S'
            puts display_matrix
          when 'COLOUR'
            puts display_colour_matrix
          else
            puts 'unrecognised command :('
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

  def display_matrix
    @matrix ? TextDisplay.new(@matrix).display : error
  end

  def display_colour_matrix
    @matrix ? ColourDisplay.new(@matrix).display : error
  end

  def clear_matrix
    @matrix ? @matrix.clear : error
  end

  def draw_rectangle(x_start, x_end, y_start, y_end, colour)
    @matrix ? @matrix.draw_rectangle(x_start, x_end, y_start, y_end, colour) : error
  end

  def colour_pixel(x, y, colour)
    @matrix ? @matrix.colour_pixel(x, y, colour) : error
  end

  def fill(x, y, colour)
    @matrix ? @matrix.fill(x, y, colour) : error
  end

  def draw_vertical_segment(x, y_start, y_end, colour)
    @matrix ? @matrix.draw_vertical_segment(x, y_start, y_end, colour) : error
  end

  def draw_horizontal_segment(y, x_start, x_end, colour)
    @matrix ? @matrix.draw_horizontal_segment(y, x_start, x_end, colour) : error
  end

  def error
    puts 'Create an Image first.'
  end

  def exit_console
    puts 'goodbye!'
    @running = false
  end

  def display_start_image
    matrix = Matrix.new(26, 7)
    # Generate colorful background
    1.upto(matrix.width) do |x|
      1.upto(matrix.height) do |y|
        matrix.colour_pixel(x, y, ['S', 'B', 'C', 'M'].sample)
      end
    end

    # Letter "H"
    matrix.draw_vertical_segment(2, 2, 6, 'O')
    matrix.draw_vertical_segment(5, 2, 6, 'O')
    matrix.draw_horizontal_segment(4, 3, 4, 'O')
    # Letter "E"
    matrix.draw_vertical_segment(7, 2, 6, 'O')
    matrix.draw_horizontal_segment(2, 8, 10 ,'O')
    matrix.draw_horizontal_segment(4, 8, 9 ,'O')
    matrix.draw_horizontal_segment(6, 8, 10 ,'O')
    # Letter "L"
    matrix.draw_vertical_segment(12, 2, 6, 'O')
    matrix.draw_horizontal_segment(6, 13, 15 ,'O')
    # Letter "L"
    matrix.draw_vertical_segment(17, 2, 6, 'O')
    matrix.draw_horizontal_segment(6, 18, 20 ,'O')
    # Letter "O"
    matrix.draw_vertical_segment(22, 3, 5, 'O')
    matrix.draw_vertical_segment(25, 3, 5, 'O')
    matrix.draw_horizontal_segment(2, 23, 24 ,'O')
    matrix.draw_horizontal_segment(6, 23, 24 ,'O')

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
