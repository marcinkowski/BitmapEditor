require './app/matrix'

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

  it 'rises error when width exceed max width' do
    expect { Matrix.new(251, 10) }.to raise_error(ArgumentError)
  end

  it 'rises error when width is lower than 0' do
    expect { Matrix.new(-1, 10) }.to raise_error(ArgumentError)
  end

  it 'rises error when height exceed max height' do
    expect { Matrix.new(10, 251) }.to raise_error(ArgumentError)
  end

  it 'rises error when height is lower than 0' do
    expect { Matrix.new(10, -1) }.to raise_error(ArgumentError)
  end

  it 'rises error when background color is invalid' do
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
end