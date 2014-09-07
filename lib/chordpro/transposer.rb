# https://github.com/patchfx/transpose_chords/blob/master/lib/transpose_chords.rb
module Chordpro
  class Transposer
    FLATS = %w(C Db D Eb E F Gb G Ab A Bb B)
    SHARPS = %w(C C# D D# E F F# G G# A A# B)

    def initialize(song, interval)
      @song = song
      @interval = interval
      @scale = SHARPS
    end

    def visit
      Song.new @song.accept(self)
    end
    
    def chord(chord)
      Chord.new(chord.name.gsub(/([A-G][#b]?)/) { |match|
        @scale[(index(match) + @interval) % @scale.size]
      })
    end

    def index(name)
      FLATS.index(name) || SHARPS.index(name)
    end
  end
end
