module Chordpro
  class Lyric < Struct.new(:text)
    def to_s
      text
    end
  end
end
