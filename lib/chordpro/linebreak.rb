module Chordpro
  class Linebreak
    def accept(visitor)
      visitor.visit_linebreak(self) if visitor.respond_to?(:visit_linebreak)
    end
  end
end
