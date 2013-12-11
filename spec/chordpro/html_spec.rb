require 'spec_helper'

describe Chordpro::HTML do
  def html(string)
    Chordpro.html(string)
  end

  %w(title t).each do |name|
    it "renders h1 for #{name}" do
      expect(html("{#{name}: Blackbird}").to_s).to eq('<h1 class="title">Blackbird</h1>')
    end
  end

  it 'guards against xss in the title' do
    expect(html('{title: <script>alert("oops");</script>}').to_s).to_not include('<script>')
  end

  %w(subtitle st su).each do |name|
    it "renders h2 for #{name}" do
      expect(html("{#{name}:The Beatles}").to_s).to eq('<h2 class="subtitle">The Beatles</h2>')
    end
  end

  it 'guards against xss in the subtitle' do
    expect(html('{subtitle: <script>alert("oops");</script>}').to_s).to_not include('<script>')
  end

  it "renders line" do
    expect(html("[G7]I dreamed I [C]held you in my [G]arms").to_s).to eq(
      '<table><tr class="chords"><td>G7</td><td>C</td><td>G</td></tr>' +
      '<tr><td>I dreamed I </td><td>held you in my </td><td>arms</td></tr></table>'
    )
  end

  it 'guards against xss in chords and lyrics' do
    expect(html('[<script>alert("oops");</script>]<script>alert("oops");</script>').to_s).to_not include('<script>')
  end

  it 'does not blow up with multiple chords in a row' do
    expect(html('[G][C][D]')).to eq(
      '<table><tr class="chords"><td>G</td><td>C</td><td>D</td></tr></table>'
    )
  end

end
