require 'spec_helper'

describe Chordpro::Chord do
  describe 'to_s' do
    {
      'Bb' => 'B♭',
      'F#m' => 'F♯m',
      'Gaug7' => 'G+⁷',
      'Ddim7' => 'D°⁷',
      'Csus9' => 'Cˢᵘˢ⁹',
      'Asus2' => 'Aˢᵘˢ²',
      'Esus4' => 'Eˢᵘˢ⁴',
      'E5' => 'E⁵',
      'Cm6' => 'Cm⁶',
      'G7' => 'G⁷',
      'Asus9' => 'Aˢᵘˢ⁹'
    }.each do |input, output|
      it "replaces #{input.inspect} with #{output.inspect}" do
        expect(Chordpro::Chord.new(input).to_s).to eq(output)
      end
    end
  end
end
