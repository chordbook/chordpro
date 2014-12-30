require 'spec_helper'

describe Chordpro::Song do
  describe '[]' do
    it "returns the value of the first directive" do
      expect(Chordpro.parse("{capo:4}\n{capo:5}")["capo"]).to eql("4")
    end

    it "returns nil if directive is not found" do
      expect(Chordpro.parse("[G]Nope")["capo"]).to be_nil
    end
  end
end
