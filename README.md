# Chordpro

A ruby parser for the [chordpro](http://tenbyten.com/software/songsgen/help/HtmlHelp/files_reference.htm) song file format.

## Installation

Add this line to your application's Gemfile:

    gem 'chordpro'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chordpro

## Usage

```ruby
html = Chordpro.html(File.read('spec/fixtures/sunshine.crd'))
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
