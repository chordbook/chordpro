require 'spec_helper'

describe Chordpro::Transposer do
  let(:interval) { 2 }
  let(:fixture) { File.read(File.expand_path('../../fixtures/sunshine.crd', __FILE__)) }
  let(:song) { Chordpro.parse(fixture) }
  let(:transposer) { Chordpro::Transposer.new(song, interval) }

  describe "visit" do
    subject { transposer.visit }

    it "returns a new song" do
      expect(subject).to be_instance_of(Chordpro::Song)
      expect(subject.elements.size).to eq(song.elements.size)
    end
  end

  describe "chord" do
    context 'up 2 half steps' do
      let(:interval) { 2 }

      Hash[*%w(C D  D E  E F#  F G  G A  A B  B C#  G/B A/C#)].each do |before, after|
        it "transposes #{before} to #{after}" do
          actual = transposer.chord(Chordpro::Chord.new(before))
          expect(actual).to eq(Chordpro::Chord.new(after))
        end
      end

      Hash[*%w(F G  G A  A B  Bb C  C D  D E  E F#)].each do |before, after|
        it "transposes #{before} to #{after}" do
          actual = transposer.chord(Chordpro::Chord.new(before))
          expect(actual).to eq(Chordpro::Chord.new(after))
        end
      end
    end
  end

  describe "integration" do
    let(:interval) { -2 }
    let(:chords) { ChordList.new(transposer.visit) }

    class ChordList < Set
      def initialize(song)
        super()
        song.accept(self)
      end

      def chord(chord)
        self << chord
      end
    end

    it "properly chooses flats" do
      expect(chords.map(&:name)).to eq(["F", "F7", "Bb", "C7"])
    end
  end
end
