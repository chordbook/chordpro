require 'builder'

module Chordpro
  class HTML
    def initialize(song)
      @song = song
      @html = Builder::XmlMarkup.new
      @song.accept(self)
    end

    def to_s
      @html.target!
    end

    def title(title)
      @html.h1(:class => 'title') { |h1| h1.text! title }
    end
    alias_method :t, :title

    def subtitle(subtitle)
      @html.h2(:class => 'subtitle') { |h2| h2.text! subtitle }
    end
    alias_method :st, :subtitle
    alias_method :su, :subtitle

    def line(line, parts)
      chords = []
      lyrics = []

      line.each do |element|
        if element.is_a?(Lyric)
          lyrics << element
        elsif element.is_a?(Chord)
          if chords[lyrics.size]
            chords << element
            lyrics << nil
          else
            chords[lyrics.size] = element
          end
        end
      end

      # ensure chords has same number of cells as lyrics
      chords[lyrics.size - 1] ||= nil if lyrics.size > 0

      @html.table do |table|
        if chords.any?
          table.tr(:class => 'chords') do |tr|
            chords.each do |chord|
              tr.td {|td| td.text! chord.to_s }
            end
          end
        end
        if lyrics.any?
          table.tr do |tr|
            lyrics.each do |lyric|
              tr.td {|td| td.text! lyric.to_s }
            end
          end
        end
      end
    end

    def linebreak(_)
      @html.br
    end

    def comment(text)
      @html.span(text, :class => 'comment')
    end
    alias_method :c, :comment

  end
end
