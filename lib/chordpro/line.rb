module Chordpro
  class Line < Struct.new(:parts)
    include Enumerable

    def each(&block)
      parts.each(&block)
    end

    def accept(visitor)
      parts = map { |part| part.accept(visitor) }
      if visitor.respond_to?(:line)
        visitor.line(self, parts)
      else
        Line.new(parts)
      end
    end
  end
end
