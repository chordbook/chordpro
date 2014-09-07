module Chordpro
  class Lyric < Struct.new(:text)
    def to_s
      text
    end

    def accept(visitor)
      visitor.respond_to?(:lyric) ? visitor.lyric(self) : self
    end
  end
end
