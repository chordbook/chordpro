module Chordpro
  class Transposer
    NOTES = %w(C Cb C# D Db D# E Eb E# F Fb F# G Gb G# A Ab A# B Bb B#)

    TRANSPOSITIONS = %w(Cb C C# Bb Cb C C C# D Db D D# C Db D D D# E Eb E F D Eb
      E E E# F# E F F# Eb Fb F F F# G Gb G G# F Gb G G G# A Ab A A# G Ab A A A#
      B Bb B C A Bb B B B# C#
    )

    def initialize(song, interval)
      @song = song
      @interval = interval
    end

    def visit
      Song.new @song.accept(self)
    end

    def chord(chord)
      Chord.new(transpose(chord))
    end

    def transpose(chord)
      chord.name.gsub(/([A-G][#b]?)/) do |match|
        @interval.abs.times do
          index = NOTES.index(match)
          match = TRANSPOSITIONS[3 * index - 2 + 3 + (@interval <=> 0)]
        end
        match
      end
    end
  end
end
