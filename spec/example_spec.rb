require 'spec_helper'

describe 'Examples' do
  Dir[File.expand_path('../fixtures/*.crd', __FILE__)].each do |file|
    name = File.basename(file)

    describe name, :example => name do
      it 'matches the example' do
        html_file = file.gsub(/\.crd$/, '.html')
        actual = Chordpro.html(File.read(file))

        # Allow overwriting the HTML fixture with the actual output. This is
        # useful when the desired output format changes.
        File.open(html_file, 'w') { |f| f << actual } if ENV['OVERWRITE']

        expected = File.read(html_file)

        expect(actual).to eq(expected)
      end
    end

  end
end
