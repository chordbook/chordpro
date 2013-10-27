require 'nokogiri'

module Chordpro
  class HTML
    def initialize(song)
      @song = song
    end

    def to_s
      @song.elements.map { |e| element(e) }.join("\n")
    end

    def element(element)
      send method_for_element(element), element
    end

    def directive(directive)
      send directive.name, directive if respond_to?(directive.name)
    end

    def title(directive)
      %Q|<h1 class="title">#{directive.value}</h1>|
    end
    alias_method :t, :title

    def subtitle(directive)
      %Q|<h2 class="subtitle">#{directive.value}</h2>|
    end
    alias_method :st, :subtitle
    alias_method :su, :subtitle

    def line(line)
      chords = []
      lyrics = []

      line.elements.each do |element|
        if element.is_a?(Sexp::Lyric)
          lyrics << element
        elsif element.is_a?(Sexp::Chord)
          chords[lyrics.size] = element
        end
      end

      %Q|<table><tr class="chords">#{
        chords.map {|l| "<td>#{l}</td>" }.join
      }</tr><tr>#{
        lyrics.map {|l| "<td>#{l}</td>" }.join
      }</tr></table>|
    end

    def newline(_)
      '<br>'
    end

    def comment(directive)
      %|<span class="comment">#{directive.value}</span>|
    end
    alias_method :c, :comment

    private

    def method_for_element(element)
      element.class.name.split('::').last.downcase
    end

  end
end
