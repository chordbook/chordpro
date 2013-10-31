module Chordpro
  class Line < Struct.new(:parts)
    include Enumerable

    def each(&block)
      parts.each(&block)
    end

    def accept(visitor)
      visitor.visit_line(self) if visitor.respond_to?(:visit_line)
    end
  end
end
