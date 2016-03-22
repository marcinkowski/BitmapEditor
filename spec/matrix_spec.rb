require './app/matrix'
require './app/display/colour_display'

RSpec.describe(Matrix) do
  let(:matrix) { Matrix.new(10, 6) }

  it 'has defined width of bitmap' do
    expect(matrix.width).to eq(10)
  end

  it 'has defined height of bitmap' do
    expect(matrix.height).to eq(6)
  end

  it 'has defined background color' do
    expect(matrix.background).to eq('O')
  end

  it 'raises error when width exceed max width' do
    expect { Matrix.new(251, 10) }.to raise_error(ArgumentError)
  end

  it 'raises error when width is lower than 0' do
    expect { Matrix.new(-1, 10) }.to raise_error(ArgumentError)
  end

  it 'raises error when height exceed max height' do
    expect { Matrix.new(10, 251) }.to raise_error(ArgumentError)
  end

  it 'raises error when height is lower than 0' do
    expect { Matrix.new(10, -1) }.to raise_error(ArgumentError)
  end

  it 'raises error when background color is invalid' do
    expect { Matrix.new(10, 10, 'TEST') }.to raise_error(ArgumentError)
  end

  it 'colours pixel' do
    matrix.colours_pixel(1, 2, 'A')
    expect(matrix.bitmap).to eq({[1, 2] => 'A'})
  end

  it 'rises error when X parameter is invalid' do
    expect { matrix.colours_pixel(11, 2, 'A') }.to raise_error(ArgumentError)
  end

  it 'rises error when Y parameter is invalid' do
    expect { matrix.colours_pixel(10, 7, 'A') }.to raise_error(ArgumentError)
  end

  it 'draws vertical segment' do
    matrix.draw_vertical_segment(2, 3, 5, 'A')
    expect(matrix.bitmap).to eq({[2, 3] => 'A', [2, 4] => 'A', [2, 5] => 'A'})
  end

  it 'draws horizontal segment' do
    matrix.draw_horizontal_segment(3, 8, 10, 'A')
    expect(matrix.bitmap).to eq({[8, 3] => 'A', [9, 3] => 'A', [10, 3] => 'A'})
  end

  it 'clears bitmap' do
    matrix.colours_pixel(1, 2, 'A')
    matrix.clear
    expect(matrix.bitmap).to eq({})
  end

  it 'fills empty bitmap with different colour' do
    matrix = Matrix.new(4,4)
    matrix.fill(3,3, 'A')

    expect(matrix.bitmap).to eq({
      [3, 3]=>"A", [4, 4]=>"A", [4, 3]=>"A", [3, 4]=>"A",
      [2, 3]=>"A",[1, 4]=>"A", [1, 3]=>"A", [2, 4]=>"A",
      [2, 2]=>"A", [1, 1]=>"A", [1, 2]=>"A", [2, 1]=>"A",
      [3, 2]=>"A", [4, 1]=>"A", [4, 2]=>"A", [3, 1]=>"A"
    })
  end

  it 'fills empty half of bitmap with different colour' do
    matrix = Matrix.new(5,5)
    matrix.draw_horizontal_segment(1, 1, 5, 'N')
    matrix.draw_horizontal_segment(2, 1, 5, 'N')
    matrix.draw_horizontal_segment(3, 1, 5, 'N')
    matrix.fill(4,4, 'G')

    expect(matrix.bitmap).to eq({
      [1, 1]=>"N", [2, 1]=>"N", [3, 1]=>"N", [4, 1]=>"N", [5, 1]=>"N",
      [1, 2]=>"N", [2, 2]=>"N", [3, 2]=>"N", [4, 2]=>"N", [5, 2]=>"N",
      [1, 3]=>"N", [2, 3]=>"N", [3, 3]=>"N", [4, 3]=>"N", [5, 3]=>"N",
      [4, 4]=>"G", [5, 5]=>"G", [5, 4]=>"G", [4, 5]=>"G", [3, 4]=>"G",
      [2, 5]=>"G", [1, 4]=>"G", [1, 5]=>"G", [2, 4]=>"G", [3, 5]=>"G"
    })
  end

  it 'fills coloured half of bitmap with different colour' do
    matrix = Matrix.new(5,5)
    matrix.draw_horizontal_segment(1, 1, 5, 'N')
    matrix.draw_horizontal_segment(2, 1, 5, 'N')
    matrix.draw_horizontal_segment(3, 1, 5, 'N')
    matrix.fill(2,2, 'Y')

    expect(matrix.bitmap).to eq({
      [1, 1]=>"Y", [2, 1]=>"Y", [3, 1]=>"Y", [4, 1]=>"Y", [5, 1]=>"Y",
      [1, 2]=>"Y", [2, 2]=>"Y", [3, 2]=>"Y", [4, 2]=>"Y", [5, 2]=>"Y",
      [1, 3]=>"Y", [2, 3]=>"Y", [3, 3]=>"Y", [4, 3]=>"Y", [5, 3]=>"Y"
    })
  end

  it 'fills empty space of bitmap with different colour without borders' do
    matrix = Matrix.new(5,5)
    matrix.draw_horizontal_segment(3, 1, 2, 'N')
    matrix.draw_horizontal_segment(3, 4, 5, 'N')
    matrix.fill(4,4, 'Y')

    expect(matrix.bitmap).to eq({
      [1, 3]=>"N", [2, 3]=>"N", [4, 3]=>"N", [5, 3]=>"N", [4, 4]=>"Y",
      [5, 5]=>"Y", [5, 4]=>"Y", [4, 5]=>"Y", [3, 4]=>"Y", [2, 5]=>"Y",
      [1, 4]=>"Y", [1, 5]=>"Y", [2, 4]=>"Y", [3, 5]=>"Y", [3, 3]=>"Y",
      [2, 2]=>"Y", [1, 1]=>"Y", [1, 2]=>"Y", [2, 1]=>"Y", [3, 2]=>"Y",
      [4, 1]=>"Y", [5, 2]=>"Y", [5, 1]=>"Y", [4, 2]=>"Y", [3, 1]=>"Y"
    })
  end

  it 'fills coloured space of bitmap with different colour without borders' do
    matrix = Matrix.new(5,5)
    matrix.draw_horizontal_segment(1, 1, 5, 'N')
    matrix.draw_horizontal_segment(2, 1, 5, 'N')
    matrix.colours_pixel(3, 3, 'N')
    matrix.draw_horizontal_segment(4, 1, 5, 'N')
    matrix.draw_horizontal_segment(5, 1, 5, 'N')
    matrix.fill(2,2, 'Y')

    expect(matrix.bitmap).to eq({
      [1, 1]=>"Y", [2, 1]=>"Y", [3, 1]=>"Y", [4, 1]=>"Y", [5, 1]=>"Y",
      [1, 2]=>"Y", [2, 2]=>"Y", [3, 2]=>"Y", [4, 2]=>"Y", [5, 2]=>"Y",
      [3, 3]=>"Y", [1, 4]=>"Y", [2, 4]=>"Y", [3, 4]=>"Y", [4, 4]=>"Y",
      [5, 4]=>"Y", [1, 5]=>"Y", [2, 5]=>"Y", [3, 5]=>"Y", [4, 5]=>"Y",
      [5, 5]=>"Y"
    })
  end

  it 'fills empty space of bitmap with different colour limited by borders made by square corners' do
    matrix = Matrix.new(8,8)
    matrix.draw_horizontal_segment(1, 1, 4, 'N')
    matrix.draw_horizontal_segment(2, 1, 4, 'N')
    matrix.draw_horizontal_segment(3, 1, 4, 'N')
    matrix.draw_horizontal_segment(4, 1, 4, 'N')
    matrix.draw_horizontal_segment(5, 5, 8, 'N')
    matrix.draw_horizontal_segment(6, 5, 8, 'N')
    matrix.draw_horizontal_segment(7, 5, 8, 'N')
    matrix.draw_horizontal_segment(8, 5, 8, 'N')
    matrix.fill(7,2, 'Y')
    expect(matrix.bitmap).to eq({
      [1, 1]=>"N", [2, 1]=>"N", [3, 1]=>"N", [4, 1]=>"N", [1, 2]=>"N",
      [2, 2]=>"N", [3, 2]=>"N", [4, 2]=>"N", [1, 3]=>"N", [2, 3]=>"N",
      [3, 3]=>"N", [4, 3]=>"N", [1, 4]=>"N", [2, 4]=>"N", [3, 4]=>"N",
      [4, 4]=>"N", [5, 5]=>"N", [6, 5]=>"N", [7, 5]=>"N", [8, 5]=>"N",
      [5, 6]=>"N", [6, 6]=>"N", [7, 6]=>"N", [8, 6]=>"N", [5, 7]=>"N",
      [6, 7]=>"N", [7, 7]=>"N", [8, 7]=>"N", [5, 8]=>"N", [6, 8]=>"N",
      [7, 8]=>"N", [8, 8]=>"N", [7, 2]=>"Y", [7, 1]=>"Y", [8, 1]=>"Y",
      [8, 2]=>"Y", [8, 3]=>"Y", [8, 4]=>"Y", [7, 4]=>"Y", [7, 3]=>"Y",
      [6, 3]=>"Y", [6, 2]=>"Y", [6, 1]=>"Y", [5, 1]=>"Y", [5, 2]=>"Y",
      [5, 3]=>"Y", [5, 4]=>"Y", [6, 4]=>"Y"
     })
  end

  it 'fills coloured space of bitmap with different colour limited by borders made by square corners' do
    matrix = Matrix.new(8,8)
    matrix.draw_horizontal_segment(1, 1, 4, 'N')
    matrix.draw_horizontal_segment(2, 1, 4, 'N')
    matrix.draw_horizontal_segment(3, 1, 4, 'N')
    matrix.draw_horizontal_segment(4, 1, 4, 'N')
    matrix.draw_horizontal_segment(5, 5, 8, 'N')
    matrix.draw_horizontal_segment(6, 5, 8, 'N')
    matrix.draw_horizontal_segment(7, 5, 8, 'N')
    matrix.draw_horizontal_segment(8, 5, 8, 'N')
    matrix.fill(2,2, 'Y')

    expect(matrix.bitmap).to eq({
      [1, 1]=>"Y", [2, 1]=>"Y", [3, 1]=>"Y", [4, 1]=>"Y", [1, 2]=>"Y",
      [2, 2]=>"Y", [3, 2]=>"Y", [4, 2]=>"Y", [1, 3]=>"Y", [2, 3]=>"Y",
      [3, 3]=>"Y", [4, 3]=>"Y", [1, 4]=>"Y", [2, 4]=>"Y", [3, 4]=>"Y",
      [4, 4]=>"Y", [5, 5]=>"N", [6, 5]=>"N", [7, 5]=>"N", [8, 5]=>"N",
      [5, 6]=>"N", [6, 6]=>"N", [7, 6]=>"N", [8, 6]=>"N", [5, 7]=>"N",
      [6, 7]=>"N", [7, 7]=>"N", [8, 7]=>"N", [5, 8]=>"N", [6, 8]=>"N",
      [7, 8]=>"N", [8, 8]=>"N"
    })
  end

  it 'fills space of bitmap with different colour limited by line border of other colour' do
    matrix = Matrix.new(5,5)
    matrix.draw_horizontal_segment(3, 1, 5, 'N')
    matrix.fill(2,2, 'Y')

    expect(matrix.bitmap).to eq({
      [1, 3]=>"N", [2, 3]=>"N", [3, 3]=>"N", [4, 3]=>"N", [5, 3]=>"N",
      [2, 2]=>"Y", [2, 1]=>"Y", [3, 1]=>"Y", [3, 2]=>"Y", [4, 2]=>"Y",
      [4, 1]=>"Y", [5, 1]=>"Y", [5, 2]=>"Y", [1, 1]=>"Y", [1, 2]=>"Y"
    })
  end

  it 'fills space of bitmap with different colour limited by diagonal border of other colour' do
    matrix = Matrix.new(5,5)
    matrix.colours_pixel(1, 1, 'N')
    matrix.colours_pixel(2, 2, 'N')
    matrix.colours_pixel(3, 3, 'N')
    matrix.colours_pixel(4, 4, 'N')
    matrix.colours_pixel(5, 5, 'N')
    matrix.fill(3,2, 'Y')

    expect(matrix.bitmap).to eq({
      [1, 1]=>"N", [2, 2]=>"N", [3, 3]=>"N", [4, 4]=>"N", [5, 5]=>"N",
      [3, 2]=>"Y", [3, 1]=>"Y", [4, 1]=>"Y", [4, 2]=>"Y", [4, 3]=>"Y",
      [5, 3]=>"Y", [5, 2]=>"Y", [5, 1]=>"Y", [5, 4]=>"Y", [2, 1]=>"Y"
    })
  end

  it 'fills space of one pixel with different colour' do
    matrix = Matrix.new(5,5)
    matrix.colours_pixel(3, 3, 'N')
    matrix.fill(3, 3, 'Y')

    expect(matrix.bitmap).to eq({[3, 3]=>"Y"})
  end

  it 'fills pixel that does not exist' do
    expect { matrix.fill(10, 30, 'Y') }.to raise_error(ArgumentError)
  end
end