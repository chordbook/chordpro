require 'spec_helper'

describe Chordpro::Chord do
  describe 'to_s' do
    {
      'Bb' => 'B♭',
      'F#m' => 'F♯m',
      'Gaug7' => 'G+⁷',
      'Ddim7' => 'D°⁷',
      'Csus9' => 'Csus⁹',
      'Asus2' => 'Asus²',
      'Esus4' => 'Esus⁴',
      'E5' => 'E⁵',
      'Cm6' => 'Cm⁶',
      'G7' => 'G⁷',
      'Asus9' => 'Asus⁹'
    }.each do |input, output|
      it "replaces #{input.inspect} with #{output.inspect}" do
        expect(Chordpro::Chord.new(input).to_s).to eq(output)
      end
    end
  end
end
