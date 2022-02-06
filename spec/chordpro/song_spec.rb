require "spec_helper"

module Chordpro
  describe Song do
    describe "metadata" do
      let(:song) { Chordpro.parse("{title: Africa}\n{artist: Justin Timberlake}\n{artist: Jimmy Fallon}") }

      it "returns nil if missing" do
        expect(song.metadata["capo"]).to be(nil)
      end

      it "returns single value" do
        expect(song.metadata["title"]).to eq("Africa")
        expect(song.metadata[:title]).to eq("Africa")
      end

      it "returns array for multiple values" do
        expect(song.metadata["artist"]).to eq(["Justin Timberlake", "Jimmy Fallon"])
        expect(song.metadata[:artist]).to eq(song.metadata["artist"])
      end

      it "returns nil for unknown directive" do
        song = Chordpro.parse("{foo: bar}")
        expect(song.metadata["foo"]).to eq(nil)
      end

      it "returns hash with to_h" do
        expect(song.metadata.to_h).to eq({
          "title" => "Africa",
          "artist" => ["Justin Timberlake", "Jimmy Fallon"]
        })
      end
    end

    describe "method_missing" do
      let(:song) { Chordpro.parse("{title: The Title}\n{st: The Subtitle}") }

      it "responds to method for directives" do
        expect(song.respond_to?(:title)).to be(true)
        expect(song.respond_to?(:subtitle)).to be(true)
        expect(song.title).to eq("The Title")
        expect(song.subtitle).to eq("The Subtitle")
      end

      it "responds to method for directive aliases" do
        expect(song.respond_to?(:t)).to be(true)
        expect(song.respond_to?(:st)).to be(true)
        expect(song.t).to eq("The Title")
        expect(song.st).to eq("The Subtitle")
      end

      it "does not respond to unknown directive" do
      end
    end
  end
end
