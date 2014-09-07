require "spec_helper"

describe Chordpro::Directive do
  describe "accept" do
    let(:visitor) { double(:visitor) }
    let(:directive) { Chordpro::Directive.new("title", "The Visitor")}

    it "calls method on visitor" do
      expect(visitor).to receive(:title).and_return('title')
      expect(directive.accept(visitor)).to eq('title')
    end

    it "returns self when visitor does not respond to method" do
      expect(directive.accept(visitor)).to be(directive)
    end
  end
end
