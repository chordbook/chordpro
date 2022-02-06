require "chordpro/chord"
require "chordpro/directive"
require "chordpro/html"
require "chordpro/line"
require "chordpro/linebreak"
require "chordpro/lyric"
require "chordpro/metadata"
require "chordpro/parser"
require "chordpro/song"
require "chordpro/transform"
require "chordpro/version"

require "chordpro/setup"

module Chordpro
  def self.parse(string)
    Transform.new.apply(Parser.new.parse(string))
  end

  def self.html(string)
    HTML.new(parse(string)).to_s
  end
end
