module Chordpro
  class Transform < Parslet::Transform
    rule(directive: {name: simple(:name), value: simple(:value)}) do
      directive_name = Directive.find(name) || Directive::Name.new(name.to_s)
      Chordpro::Directive.new(directive_name, value.to_s)
    end

    rule(directive: {name: simple(:name)}) do
      directive_name = Directive.find(name) || Directive::Name.new(name.to_s)
      Chordpro::Directive.new(directive_name)
    end

    rule(linebreak: simple(:x)) { Chordpro::Linebreak.new }
    rule(chord: simple(:name)) { Chordpro::Chord.new(name.to_s) }
    rule(lyric: simple(:text)) { Chordpro::Lyric.new(text.to_s) }
    rule(line: subtree(:parts)) { Chordpro::Line.new(parts) }
    rule(song: subtree(:elements)) { Chordpro::Song.new(elements) }
  end
end
