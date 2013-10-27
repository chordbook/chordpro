require 'spec_helper'

describe 'Examples' do
  Dir[File.expand_path('../fixtures/*.crd', __FILE__)].each do |file|
    name = File.basename(file)

    describe name, :example => name do
      it 'matches the example' do
        song = Chordpro::Parser.parse(File.read(file))
        expected = Chordpro::HTML.new(song).to_s
        actual = File.read(file.gsub(/\.crd$/, '.html'))

        expect(expected).to eq(actual)
      end
    end

  end
end
