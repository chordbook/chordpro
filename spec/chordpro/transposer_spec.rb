require 'spec_helper'

describe Chordpro::Transposer do
  let(:interval) { 2 }
  let(:fixture) { File.read(File.expand_path('../../fixtures/sunshine.crd', __FILE__)) }
  let(:song) { Chordpro::Transform.new.apply(Chordpro::Parser.new.parse(fixture)) }
  let(:transposer) { Chordpro::Transposer.new(song, interval) }

  describe "visit" do
    subject { transposer.visit }

    it "returns a new song" do
      expect(subject).to be_instance_of(Chordpro::Song)
      expect(subject.elements.size).to eq(song.elements.size)
    end

    it "transposes each chord" do

    end
  end

  describe "chord" do
    context 'up 2 half steps' do
      let(:interval) { 2 }

      Hash[*%w(C D  D E  E F#  F G  G A  A B  B C#)].each do |before, after|
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
end
