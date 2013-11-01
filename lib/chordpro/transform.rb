module Chordpro
  class Transform < Parslet::Transform
    rule(:directive => {:name => simple(:name), :value => simple(:value)}) do
      Chordpro::Directive.new(name.to_s, value.to_s)
    end
    rule(:directive => {:name => simple(:name)}) do
      Chordpro::Directive.new(name.to_s)
    end

    rule(:linebreak => simple(:x))    { Chordpro::Linebreak.new }
    rule(:chord => simple(:name))     { Chordpro::Chord.new(name.to_s) }
    rule(:lyric => simple(:text))     { Chordpro::Lyric.new(text.to_s) }
    rule(:line => subtree(:parts))    { Chordpro::Line.new(parts) }
    rule(:song => subtree(:elements)) { Chordpro::Song.new(elements) }
  end
end
