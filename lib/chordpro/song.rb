module Chordpro
  class Song
    attr_reader :elements, :metadata

    def initialize(elements = [])
      @elements = elements
      @metadata = Metadata.new(@elements)
    end

    def accept(visitor)
      elements.map { |element| element.accept(visitor) }
    end

    def method_missing(method, *args)
      if respond_to_missing?(method)
        metadata[method]
      else
        super
      end
    end

    def respond_to_missing?(method, include_all = false)
      super || !!Directive.find(method)&.meta
    end
  end
end
