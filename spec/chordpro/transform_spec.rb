require 'spec_helper'

describe Chordpro::Transform do
  let(:transform) { Chordpro::Transform.new }

  describe 'directive' do
    subject { transform.apply(:directive => {:name => 'title', :value => 'Two of Us'}) }

    it { should be_kind_of(Chordpro::Directive) }
    it { expect(subject.name).to eq('title') }
    it { expect(subject.value).to eq('Two of Us') }
  end

  describe 'directive without a value' do
    subject { transform.apply(:directive => {:name => 'soc'}) }

    it { should be_kind_of(Chordpro::Directive) }
    it { expect(subject.name).to eq('soc') }
  end

  describe 'chord' do
    subject { transform.apply(:chord => 'G') }

    it { should be_kind_of(Chordpro::Chord) }
    it { expect(subject.name).to eq('G') }
  end

  describe 'chord' do
    subject { transform.apply(:chord => 'G') }

    it { should be_kind_of(Chordpro::Chord) }
    it { expect(subject.name).to eq('G') }
  end

  describe 'linebreak' do
    subject { transform.apply(:linebreak => "\n") }

    it { should be_kind_of(Chordpro::Linebreak) }
  end

  describe 'line' do
    subject do
      transform.apply(:line => [
        {:chord => 'G'},
        {:lyric => 'You are my sunshine'}
      ])
    end

    it { should be_kind_of(Chordpro::Line) }
    it { expect(subject.parts.length).to eq(2) }
    it { expect(subject.parts[0]).to be_instance_of(Chordpro::Chord) }
    it { expect(subject.parts[1]).to be_instance_of(Chordpro::Lyric) }
  end

  describe 'song' do
    subject do
      transform.apply(:song => [
        {:directive => {:name => 'title', :value => 'You Are My Sunshine'}},
        {:line => [{:chord => 'G'}, {:lyric => 'You are my sunshine'}]}
      ])
    end

    it { should be_kind_of(Chordpro::Song) }
  end

end
