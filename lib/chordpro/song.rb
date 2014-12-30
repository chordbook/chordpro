module Chordpro
  class Song
    attr_reader :elements

    def initialize(elements = [])
      @elements = elements
    end

    def accept(visitor)
      elements.map { |element| element.accept(visitor) }
    end

    # Get the value of a directive
    def [](name)
      directive = @elements.detect do |element|
        element.is_a?(Directive) && element.name == name
      end

      directive.value if directive
    end
  end
end
