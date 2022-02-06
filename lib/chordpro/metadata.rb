module Chordpro
  class Metadata
    include Enumerable

    def initialize(elements)
      @elements = elements
    end

    def directives
      @elements.lazy.select { |e| e.is_a?(Directive) && e.name.meta }
    end

    def each(&block)
      directives.each(&block)
    end

    def [](key)
      values = select { |directive| directive.name == key }.map(&:value)
      values.length > 1 ? values : values[0]
    end

    def to_h
      each_with_object({}) do |d, h|
        key = d.name.to_s
        h[key] = h.has_key?(key) ? Array(h[key]).push(d.value) : d.value
      end
    end
  end
end
