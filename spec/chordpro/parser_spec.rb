require 'spec_helper'

describe Chordpro::Parser do
  def parse(string)
    Chordpro::Parser.parse(string)
  end

  it 'parses a title' do
    directive = parse("{ title : foobar }").elements.first

    expect(directive).to be_kind_of(Sexp::Directive)
    expect(directive.name).to eq('title')
    expect(directive.value).to eq('foobar')
  end

  %w(A Bb C# Dm Edim Fmaj Gsus2 A/C#).each do |chord|
    it "parses #{chord} as a chord" do
      line = parse("[#{chord}]\n").elements.first

      expect(line).to be_kind_of(Sexp::Line)
      expect(line.elements.first).to be_kind_of(Sexp::Chord)
    end
  end

  it "parses a line with chords" do
    line = parse("[G7]You make me [C]happy when skies are [G]gray").elements.first

    expect(line.elements.size).to eq(6)
    # expect(line.elements[0]).to be_kind_of(Sexp::Chord)
    # expect(line.elements[1]).to be_kind_of(Sexp::Lyric)
  end

end
