module Chordpro
  class Directive < Struct.new(:name, :value)

    def accept(visitor)
      visitor.respond_to?(name) ? visitor.send(name, value) : self
    end

  end
end
