require 'nokogiri'

module Chordpro
  class HTML
    def initialize(song)
      @song = song
    end

    def to_s
      @song.elements.map do |element|
        send method_for_element(element), element
      end.join("\n")
    end

    def directive(directive)
      send directive.name, directive #if respond_to?(directive.name)
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
        else
          chords[lyrics.size] = element
        end
      end

      %Q|<table><tr class="chords">#{
        chords.map {|l| "<td>#{l}</td>" }.join
      }</tr><tr>#{
        lyrics.map {|l| "<td>#{l}</td>" }.join
      }</tr></table>|
    end

    private

    def method_for_element(element)
      element.class.name.split('::').last.downcase
    end

  end
end
