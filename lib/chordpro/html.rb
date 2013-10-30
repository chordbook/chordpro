require 'nokogiri'

module Chordpro
  class HTML
    def initialize(tree)
      @song = tree[:song]
    end

    def to_s
      @song.map { |e| elements(e) }.flatten.join("\n")
    end

    def elements(element)
      element.map do |key, value|
        send key, value
      end
    end

    def directive(directive)
      send directive[:name], directive if respond_to?(directive[:name])
    end

    def title(directive)
      %Q|<h1 class="title">#{directive[:value]}</h1>|
    end
    alias_method :t, :title

    def subtitle(directive)
      %Q|<h2 class="subtitle">#{directive[:value]}</h2>|
    end
    alias_method :st, :subtitle
    alias_method :su, :subtitle

    def line(line)
      chords = []
      lyrics = []

      line.each do |element|
        if lyric = element[:lyric]
          lyrics << lyric
        elsif chord = element[:chord]
          if chords[lyrics.size]
            chord << chord
            lyrics << nil
          else
            chords[lyrics.size] = chord
          end
        end
      end

      # ensure chords has same number of cells as lyrics
      chords[lyrics.size - 1] ||= nil if lyrics.size > 0

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
      %|<span class="comment">#{directive[:value]}</span>|
    end
    alias_method :c, :comment

  end
end
