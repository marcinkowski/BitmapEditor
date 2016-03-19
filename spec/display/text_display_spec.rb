require './app/display/text_display'

RSpec.describe(TextDisplay) do
  it 'displays a matrix' do
    matrix = instance_double('Matrix', {
        height: 3,
        width: 4,
        background: 'O',
        bitmap: {[1, 1] => 'A', [2, 2] => 'B', [3, 3] => 'C', [4, 2] => 'X'}
    })

    text_display = TextDisplay.new(matrix)
    expect(text_display.display).to eq("AOOO\nOBOX\nOOCO\n")
  end
end