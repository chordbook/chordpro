module Chordpro
  class Transposer
    def initialize(song, interval)
      @song = song
      @interval = interval
    end

    def visit
      Song.new @song.accept(self)
    end

    def chord(chord)
      chord.transpose(@interval)
    end
  end
end
