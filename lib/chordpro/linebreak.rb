module Chordpro
  class Linebreak
    def accept(visitor)
      if visitor.respond_to?(:linebreak)
        visitor.linebreak(self)
      else
        self
      end
    end
  end
end
