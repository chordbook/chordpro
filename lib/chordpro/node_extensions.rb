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
end
