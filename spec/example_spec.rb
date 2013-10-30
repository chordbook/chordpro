require 'spec_helper'

describe 'Examples' do
  Dir[File.expand_path('../fixtures/*.crd', __FILE__)].each do |file|
    name = File.basename(file)

    describe name, :example => name do
      it 'matches the example' do
        actual = Chordpro.html(File.read(file))
        expected = File.read(file.gsub(/\.crd$/, '.html'))

        File.open(file.gsub(/\.crd$/, '.html'), 'w') { |f| f << actual }

        expect(actual).to eq(expected)
      end
    end

  end
end
