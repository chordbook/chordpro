require 'spec_helper'

describe Chordpro::HTML do
  def html(string)
    Chordpro::HTML.new(Chordpro::Parser.parse(string))
  end

  %w(title t).each do |name|
    it "renders h1 for #{name}" do
      expect(html("{#{name}: Blackbird}").to_s).to eq('<h1 class="title">Blackbird</h1>')
    end
  end

  %w(subtitle st su).each do |name|
    it "renders h2 for #{name}" do
      expect(html("{#{name}:The Beatles}").to_s).to eq('<h2 class="subtitle">The Beatles</h2>')
    end
  end

end
