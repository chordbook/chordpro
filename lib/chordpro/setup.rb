# Register documented directives
# https://www.chordpro.org/chordpro/chordpro-directives/
Chordpro::Directive.class_eval do
  # preamble
  register 'new_song', aka: 'ns'

  # metadata
  register 'title', aka: 't', meta: true
  register 'sorttitle', meta: true
  register 'subtitle', aka: 'st', meta: true
  register 'artist', meta: true
  register 'composer', meta: true
  register 'lyricist', meta: true
  register 'copyright', meta: true
  register 'album', meta: true
  register 'year', meta: true
  register 'key', meta: true
  register 'time', meta: true
  register 'tempo', meta: true
  register 'duration', meta: true
  register 'capo', meta: true
  register 'meta', meta: true

  # Environment directives
  %w(chorus verse bridge tab grid).each do |directive|
    letter = directive[0]
    register "start_of_#{directive}", aka: "so#{letter}"
    register "end_of_#{directive}", aka: "eo#{letter}"
  end

  # Chord diagrams
  register 'define'
  register 'chord'
  register 'transpose'

  register 'chordfont', aka: 'cf'
  register 'chordsize', aka: 'cs'
  register 'chordcolour'
  register 'footerfont'
  register 'footersize'
  register 'footercolour'
  register 'gridfont'
  register 'gridsize'
  register 'gridcolour'
  register 'tabfont'
  register 'tabsize'
  register 'tabcolour'
  register 'tocfont'
  register 'tocsize'
  register 'toccolour'
  register 'textfont', aka: 'tf'
  register 'textsize', aka: 'ts'
  register 'textcolour'
  register 'titlefont'
  register 'titlesize'
  register 'titlecolour'

  # Output related directives
  register 'new_page', aka: 'np'
  register 'new_physical_page', aka: 'npp'
  register 'column_break', aka: 'cb'
  register 'pagetype'
end
