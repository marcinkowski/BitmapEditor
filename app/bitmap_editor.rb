class BitmapEditor

  def run
    @running = true
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
          when /^I ([1-9]+) ([1-9]+)$/
            create_matrix($1.to_i, $2.to_i)
          when /^L ([1-9]+) ([1-9]+) ([A-Z])$/
            colours_pixel($1.to_i, $2.to_i, $3)
          when /^V ([1-9]+) ([1-9]+) ([1-9]+) ([A-Z])$/
            draw_vertical_segment($1.to_i, $2.to_i, $3.to_i, $4)
          when /^H ([1-9]+) ([1-9]+) ([1-9]+) ([A-Z])$/
            draw_horizontal_segment($3.to_i, $1.to_i, $2.to_i, $4)
          when 'C'
            clear_matrix
          when 'S'
            puts display_matrix
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

  def clear_matrix
    @matrix ? @matrix.clear : error
  end

  def colours_pixel(x, y, colour)
    @matrix ? @matrix.colours_pixel(x, y, colour) : error
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

  def show_help
    puts "? - Help
I M N - Create a new M x N image with all pixels coloured white (O).
C - Clears the table, setting all pixels to white (O).
L X Y C - Colours the pixel (X,Y) with colour C.
V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
F X Y C - Fill the region R with the colour C. R is defined as: Pixel (X,Y) belongs to R. Any other pixel which is the same colour as (X,Y) and shares a common side with any pixel in R also belongs to this region.
S - Show the contents of the current image
X - Terminate the session"
  end
end
