module Chordpro
  class Directive < Struct.new(:name, :value)
    class Name
      attr_reader :aka, :meta

      def initialize(name, aka: nil, meta: false)
        @name, @aka, @meta = name, aka, meta
      end

      def to_s
        @name
      end

      def ==(other)
        to_s == other.to_s || (aka && aka == other.to_s)
      end
    end

    BY_NAME = {}
    BY_ALIAS = {}

    def self.register(name, **options)
      directive = Name.new(name, **options)

      BY_NAME[directive.to_s] = directive
      BY_ALIAS[directive.aka] = directive if directive.aka
    end

    def self.find(name)
      BY_NAME[name.to_s] || BY_ALIAS[name.to_s]
    end

    def accept(visitor)
      visitor.respond_to?(name.to_s) ? visitor.send(name.to_s, value) : self
    end
  end
end
