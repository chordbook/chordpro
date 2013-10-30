require "chordpro/version"
require "chordpro/parser"
require "chordpro/html"

module Chordpro
  def self.html(string)
    HTML.new(Parser.new.parse(string)).to_s
  end
end
