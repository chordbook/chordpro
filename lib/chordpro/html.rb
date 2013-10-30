require 'builder'

module Chordpro
  class HTML
    def initialize(tree)
      @song = tree[:song]
      @html = Builder::XmlMarkup.new
      @song.each { |e| elements(e) }
    end

    def to_s
      @html.target!
    end

    def elements(element)
      element.each do |key, value|
        send key, value
      end
    end

    def directive(directive)
      send directive[:name], directive if respond_to?(directive[:name])
    end

    def title(directive)
      @html.h1(:class => 'title') { |h1| h1.text! directive[:value].to_s }
    end
    alias_method :t, :title

    def subtitle(directive)
      @html.h2(:class => 'subtitle') { |h2| h2.text! directive[:value].to_s }
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

      @html.table do |table|
        table.tr(:class => 'chords') do |tr|
          chords.each do |chord|
            tr.td {|td| td.text! chord.to_s }
          end
        end
        table.tr do |tr|
          lyrics.each do |lyric|
            tr.td {|td| td.text! lyric.to_s }
          end
        end
      end
    end

    def newline(_)
      @html.br
    end

    def comment(directive)
      @html.span(directive[:value].to_s, :class => 'comment')
    end
    alias_method :c, :comment

  end
end
