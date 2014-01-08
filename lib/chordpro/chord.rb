module Chordpro
  class Chord < Struct.new(:name)
    Substitutions = {
      'b' => '♭',
      '#' => '♯',
      'aug' => '+',
      'dim' => '°',
      '2' => '²',
      '4' => '⁴',
      '5' => '⁵',
      '6' => '⁶',
      '7' => '⁷',
      '9' => '⁹'
    }

    Regex = /(#{Substitutions.keys.join('|')})/

    def to_s
      name.gsub(Regex) {|match| Substitutions[match] }
    end
  end
end
