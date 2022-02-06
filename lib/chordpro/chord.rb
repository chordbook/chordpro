module Chordpro
  class Chord < Struct.new(:name)
    SUBSTITUTIONS = {
      "b" => "♭",
      "#" => "♯",
      "aug" => "+",
      "dim" => "°",
      "2" => "²",
      "4" => "⁴",
      "5" => "⁵",
      "6" => "⁶",
      "7" => "⁷",
      "9" => "⁹",
      "sus" => "ˢᵘˢ"
    }

    REGEX = /(#{SUBSTITUTIONS.keys.join('|')})/

    def to_s
      name.gsub(REGEX) { |match| SUBSTITUTIONS[match] }
    end

    def accept(visitor)
      visitor.respond_to?(:chord) ? visitor.chord(self) : self
    end
  end
end
