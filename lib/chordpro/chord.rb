module Chordpro
  class Chord < Struct.new(:name)
    def to_s
      name
    end
  end
end
