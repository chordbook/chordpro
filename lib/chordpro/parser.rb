require 'parslet'

module Chordpro
  class Parser < Parslet::Parser
    # Characters
    rule(:space)    { match('\s').repeat }
    rule(:colon)    { space >> str(':') >> space }
    rule(:newline)  { str("\n") }
    rule(:lbrace)   { str('{') }
    rule(:rbrace)   { str('}') }
    rule(:lbracket) { str('[') }
    rule(:rbracket) { str(']') }


    rule(:identifier) { match['a-z'].repeat(1) }
    rule(:value) { (rbrace.absent? >> any).repeat }

    rule(:directive) do
      (
        lbrace >> space >>
        identifier.as(:name) >>
        (
          space >> colon >> space >>
          value.as(:value)
        ).maybe >>
        rbrace
      ).as(:directive) >> newline.maybe
    end
    rule(:chord) { lbracket >> (rbracket.absent? >> any).repeat.as(:chord) >> rbracket }
    rule(:lyric) { (lbracket.absent? >> newline.absent? >> any).repeat(1).as(:lyric) }
    rule(:line)  { (chord | lyric).repeat(1).as(:line) >> newline.maybe }

    rule(:song)  { (directive | newline.as(:newline) | line).repeat.as(:song) }

    root(:song)
  end
end
