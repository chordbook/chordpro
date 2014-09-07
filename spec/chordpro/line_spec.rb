require "spec_helper"

describe Chordpro::Line do
  describe "accept" do
    let(:visitor) { double(:visitor) }
    let(:line) { Chordpro::Line.new([])}

    it "calls method on visitor" do
      expect(visitor).to receive(:line).and_return('line')
      expect(line.accept(visitor)).to eq('line')
    end

    it "returns line when visitor does not respond to method" do
      expect(line.accept(visitor)).to be_instance_of(Chordpro::Line)
    end
  end

end
