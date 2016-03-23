require './app/display/colour_display'

RSpec.describe(ColourDisplay) do
  it 'displays a matrix' do
    matrix = instance_double('Matrix', {
        height: 3,
        width: 4,
        background: 'O',
        bitmap: {[1, 1] => 'R', [2, 2] => 'G', [3, 3] => 'B', [4, 2] => 'W'}
    })

    text_display = ColourDisplay.new(matrix)
    expect(text_display.display).to eq("\e[0;39;41m  \e[0m\e[0;39;40m  \e[0m\e[0;39;40m  \e[0m\e[0;39;40m  \e[0m\n\e[0;39;40m  \e[0m\e[0;39;42m  \e[0m\e[0;39;40m  \e[0m\e[0;39;47m  \e[0m\n\e[0;39;40m  \e[0m\e[0;39;40m  \e[0m\e[0;39;44m  \e[0m\e[0;39;40m  \e[0m")
  end
end