require "chordpro/chord"
require "chordpro/directive"
require "chordpro/html"
require "chordpro/line"
require "chordpro/linebreak"
require "chordpro/lyric"
require "chordpro/parser"
require "chordpro/song"
require "chordpro/transform"
require "chordpro/transposer"
require "chordpro/version"

module Chordpro
  def self.parse(text)
    Transform.new.apply(Parser.new.parse(text))
  end

  def self.html(string)
    HTML.new(parse(string)).to_s
  end
end
