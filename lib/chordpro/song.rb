module Chordpro
  class Song < Struct.new(:elements)
    def accept(visitor)
      elements.each { |element| element.accept(visitor) }
    end
  end
end
