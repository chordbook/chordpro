# http://tenbyten.com/software/songsgen/help/HtmlHelp/files_reference.htm
module Sexp
  class Song < Treetop::Runtime::SyntaxNode
  end

  # Directives are delimited by curly braces ('{' and '}')
  class Directive < Treetop::Runtime::SyntaxNode
    def name
      elements[0].text_value
    end

    def value
      elements[1].text_value.strip if elements[1]
    end
  end

  class Identifier < Treetop::Runtime::SyntaxNode
  end

  class DirectiveValue < Treetop::Runtime::SyntaxNode
  end

  class Newline < Treetop::Runtime::SyntaxNode
  end

  class Line < Treetop::Runtime::SyntaxNode
  end

  class Chord < Treetop::Runtime::SyntaxNode
    def to_s
      elements.first.text_value
    end
  end

  class ChordName < Treetop::Runtime::SyntaxNode
  end

  class Lyric < Treetop::Runtime::SyntaxNode
    def to_s
      text_value
    end
  end
end
