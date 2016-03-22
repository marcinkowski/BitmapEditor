require './app/command_interpreter'

RSpec.describe(CommandInterpreter) do
  let(:matrix) do
    instance_double('Matrix', {
        colours_pixel: 'DONE',
        draw_vertical_segment: 'DONE',
        draw_horizontal_segment: 'DONE',
        fill: 'DONE',
        clear: 'DONE',
    })
  end
  let(:text_display) { instance_double('TextDisplay') }
  let(:colour_display) { instance_double('ColourDisplay') }
  let(:command_interpreter) { CommandInterpreter.new(matrix, {'S' => text_display, 'D' => colour_display}) }

  it 'interprets command to color one pixel' do
    expect(command_interpreter.interpret('L 1 2 A')).to eq('DONE')
  end

  it 'interprets command to draw vertical segment' do
    expect(command_interpreter.interpret('H 1 2 A')).to eq('DONE')
  end

  it 'interprets command to color one pixel' do
    expect(command_interpreter.interpret('L 1 2 A')).to eq('DONE')
  end

  it 'interprets command to color one pixel' do
    expect(command_interpreter.interpret('L 1 2 A')).to eq('DONE')
  end
end