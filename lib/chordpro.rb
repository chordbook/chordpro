require "chordpro/chord"
require "chordpro/directive"
require "chordpro/html"
require "chordpro/line"
require "chordpro/linebreak"
require "chordpro/lyric"
require "chordpro/parser"
require "chordpro/song"
require "chordpro/transform"
require "chordpro/version"

module Chordpro
  def self.html(string)
    HTML.new(Parser.new.parse(string)).to_s
  end
end
