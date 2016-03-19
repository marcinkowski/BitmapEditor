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

  it 'rises error when height exceed max height' do
    expect { Matrix.new(10, 251) }.to raise_error(ArgumentError)
  end

  it 'rises error when background color is invalid' do
    expect { Matrix.new(10, 10, 'TEST') }.to raise_error(ArgumentError)
  end
end