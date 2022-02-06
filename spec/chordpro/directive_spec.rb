require "spec_helper"

describe Chordpro::Directive do
  describe "accept" do
    let(:visitor) { double(:visitor) }
    let(:directive) { Chordpro::Directive.new("title", "The Visitor") }

    it "calls method on visitor" do
      expect(visitor).to receive(:title).and_return("title")
      expect(directive.accept(visitor)).to eq("title")
    end

    it "returns self when visitor does not respond to method" do
      expect(directive.accept(visitor)).to be(directive)
    end
  end
end

describe Chordpro::Directive::Name do
  describe "==" do
    context "with alias" do
      let(:name) { Chordpro::Directive::Name.new("title", aka: "t") }

      it "equals string matching name" do
        expect(name).to eq("title")
      end

      it "equals symbol matching name" do
        expect(name).to eq(:title)
      end

      it "equals string matching alias" do
        expect(name).to eq("t")
      end

      it "equals symbol matching alias" do
        expect(name).to eq(:t)
      end

      it "equals Name matching name" do
        expect(name).to eq(described_class.new("title"))
      end

      it "does not equal other string" do
        expect(name).not_to eq("nope")
      end

      it "does not equal other Name" do
        expect(name).not_to eq(described_class.new("comment"))
      end
    end
  end
end
