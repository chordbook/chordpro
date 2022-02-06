# Chordpro

A ruby parser for the [chordpro](http://tenbyten.com/software/songsgen/help/HtmlHelp/files_reference.htm) song file format. It converts songs in the chordpro format like this…

```chordpro
{title: You Are My Sunshine}

{c:Verse 1}
[G]The other night dear as I lay sleeping
[G7]I dreamed I [C]held you in my [G]arms
[G7]But when I a[C]woke dear I was mis[G]taken
So I hung my [D7]head and [G]cried

{c:Chorus}
{soc}
You are my sunshine my only sunshine
[G7]You make me [C]happy when skies are [G]gray
[G7]You'll never [C]know dear how much I [G]love you
Please don't take [D7]my sunshine a[G]way
{eoc}
```

…to HTML, which can be styled to look something like this…

![Screenshot of HTML rendering](http://cl.ly/image/1u1j3W1k3J05/content)

## Installation

Add this line to your application's Gemfile:

    gem 'chordpro'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chordpro

## Usage

```ruby
contents = File.read('spec/fixtures/sunshine.crd')

# Generate HTML from the chordpro song
File.write('sunshine.html', Chordpro.html(contents))

# Parse and inspect the chordpro song
song = Chordpro.parse(contents)
song.title # => "You Are My Sunshine"
song.metadata.to_h # => {"title" => "You Are My Sunshine", "key" => "G"}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
