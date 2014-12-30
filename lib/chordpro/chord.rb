module Chordpro
  class Chord < Struct.new(:name)
    Notes = %w(C Cb C# D Db D# E Eb E# F Fb F# G Gb G# A Ab A# B Bb B#)

    Transpositions = %w(Cb C C# Bb Cb C C C# D Db D D# C Db D D D# E Eb E F D Eb
      E E E# F# E F F# Eb Fb F F F# G Gb G G# F Gb G G G# A Ab A A# G Ab A A A#
      B Bb B C A Bb B B B# C#
    )

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
      '9' => '⁹',
      'sus' => 'ˢᵘˢ'
    }

    Regex = /(#{Substitutions.keys.join('|')})/

    def to_s
      name.gsub(Regex) {|match| Substitutions[match] }
    end

    def accept(visitor)
      visitor.respond_to?(:chord) ? visitor.chord(self) : self
    end

    def transpose(interval)
      new_name = name.gsub(/([A-G][#b]?)/) do |match|
        interval.abs.times do
          index = Notes.index(match)
          match = Transpositions[3 * index - 2 + 3 + (interval <=> 0)]
        end
        match
      end

      Chord.new(new_name)
    end
  end
end
