require "parslet"

module Chordpro
  class Parser < Parslet::Parser
    # Characters
    rule(:space) { match('\s').repeat }
    rule(:colon) { space >> str(":") >> space }
    rule(:newline) { (str("\r\n") | str("\n")) }
    rule(:lbrace) { str("{") }
    rule(:rbrace) { str("}") }
    rule(:lbracket) { str("[") }
    rule(:rbracket) { str("]") }

    rule(:identifier) { match["a-z"].repeat(1) }
    rule(:value) { (rbrace.absent? >> any).repeat }

    rule(:comment) { str("#") >> (newline.absent? >> any).repeat >> newline.maybe }

    rule(:directive) do
      (
        lbrace >> space >>
        identifier.as(:name) >>
        (
          colon >>
          value.as(:value)
        ).maybe >>
        rbrace
      ).as(:directive) >> newline.maybe
    end
    rule(:chord) { lbracket >> (rbracket.absent? >> any).repeat.as(:chord) >> rbracket }
    rule(:lyric) { (lbracket.absent? >> newline.absent? >> any).repeat(1).as(:lyric) }
    rule(:line) { (chord | lyric).repeat(1).as(:line) >> newline.maybe }

    rule(:song) { (comment | directive | newline.as(:linebreak) | line).repeat.as(:song) }

    root(:song)
  end
end
