module Chordpro
  class Directive < Struct.new(:name, :value)

    def accept(visitor)
      method = "visit_#{name}"
      visitor.send(method, value) if visitor.respond_to?(method)
    end

  end
end
