require './app/display/text_display'

RSpec.describe(TextDisplay) do
  let(:matrix) { Matrix.new(10, 6) }

  it 'displays a matrix' do
    matrix = instance_double('Matrix', {
        height: 3,
        width: 4,
        background: 'O',
        bitmap: {[1, 1] => 'A', [2, 2] => 'B', [3, 3] => 'C', [4, 2] => 'X'}
    })

    text_display = TextDisplay.new(matrix)
    expect(text_display.display).to eq("AOOO\nOBOX\nOOCO")
  end

  it 'displays rectangle' do
    matrix.draw_rectangle(1, 3, 1, 3, 'N')
    expect_image(
        "NNNOOOOOOO
         NONOOOOOOO
         NNNOOOOOOO
         OOOOOOOOOO
         OOOOOOOOOO
         OOOOOOOOOO")
  end

  it 'displays rectangle even when parameters are not ordered' do
    matrix.draw_rectangle(3, 1, 3, 1, 'N')
    expect_image(
        "NNNOOOOOOO
         NONOOOOOOO
         NNNOOOOOOO
         OOOOOOOOOO
         OOOOOOOOOO
         OOOOOOOOOO")
  end

  def expect_image(image)
    expect(TextDisplay.new(matrix).display).to eq(image.gsub(/([\ ])+|[\n\r]$/, ''))
  end
end