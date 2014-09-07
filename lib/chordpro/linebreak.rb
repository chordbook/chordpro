module Chordpro
  class Linebreak
    def accept(visitor)
      visitor.linebreak(self) if visitor.respond_to?(:linebreak)
    end
  end
end
