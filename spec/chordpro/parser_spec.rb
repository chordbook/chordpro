require 'spec_helper'
require 'parslet/rig/rspec'

describe Chordpro::Parser do
  let(:parser) { Chordpro::Parser.new }

  subject { parser.send self.class.description }

  describe 'space' do
    it { should parse(' ') }
    it { should parse('   ') }
    it { should parse('') }
    it { should_not parse('x') }
  end

  describe 'colon' do
    it { should parse(':') }
    it { should_not parse('x') }
  end

  describe 'newline' do
    it { should parse("\n") }
    it { should_not parse("x") }
  end

  describe 'lbrace' do
    it { should parse("{") }
    it { should_not parse("[") }
  end

  describe 'rbrace' do
    it { should parse("}") }
    it { should_not parse("]") }
  end

  describe 'lbracket' do
    it { should parse("[") }
    it { should_not parse("{") }
  end

  describe 'rbracket' do
    it { should parse("]") }
    it { should_not parse("}") }
  end

  describe 'identifier' do
    it { should parse('title') }
    it { should parse('t') }
    it { should_not parse(' abcdef') }
    it { should_not parse(' ') }
    it { should_not parse('') }
  end

  describe 'value' do
    it { should parse('some value') }
    it { should parse(' ahoy ').as(' ahoy ') }
    it { should_not parse('oops}') }
  end

  describe 'comment' do
    it { should parse("# ignore this") }
    it { should_not parse("but you can't # ignore this") }
  end

  describe 'directive' do
    it { should parse('{title:Royals}').as(:directive => {:name => 'title', :value => 'Royals'}) }
    # FIXME: remove trailing space from value
    it { should parse('{ title : Get Lucky }').as(:directive => {:name => 'title', :value => 'Get Lucky '}) }
    it { should parse('{soc}').as(:directive => {:name => 'soc'}) }
    it { should_not parse('{st:oops') }
  end

  describe 'chord' do
    %w(A Bb C# Dm Edim Fmaj Gsus2 A/C#).each do |chord|
      it { should parse("[#{chord}]").as(:chord => chord) }
    end

    it { should_not parse('[G') }
  end

  describe 'lyric' do
    it { should parse("I've never seen") }
    it { should parse(" a diamond in the ")}
    it { should_not parse("in the[") }
    it { should_not parse("in the\n") }
  end

  describe 'line' do
    it { should parse("[G]You are my sunshine").as(:line => [{:chord => 'G'}, {:lyric => 'You are my sunshine'}]) }
    it { should parse("You make me [C]happy when skies are [G]gray").as(:line => [
      {:lyric => 'You make me '},
      {:chord => 'C'},
      {:lyric => 'happy when skies are '},
      {:chord => 'G'},
      {:lyric => 'gray'}
    ]) }

    it { should parse("words with a newline\n").as(:line => [{:lyric => "words with a newline"}]) }
    it { should_not parse("foo\nbar") }
  end

  describe 'song' do
    it do
      song = "# A song\n{title: I'll Fly Away}\n\n[C]I'll fly away, [C7]oh, glory\n[F]I'll fly [C]away\n"
      should parse(song).as({:song => [
        {:directive => {:name => "title", :value => "I'll Fly Away"}},
        {:linebreak => "\n"},
        {:line => [{:chord => "C"}, {:lyric => "I'll fly away, "}, {:chord => "C7"}, {:lyric => "oh, glory"}]},
        {:line => [{:chord => "F"}, {:lyric => "I'll fly "}, {:chord => "C"}, {:lyric => "away"}]}
      ]})
    end
  end
end
