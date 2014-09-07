module Chordpro
  class Song
    attr_reader :elements

    def initialize(elements = [])
      @elements = elements
    end

    def accept(visitor)
      elements.map { |element| element.accept(visitor) }
    end
  end
end
