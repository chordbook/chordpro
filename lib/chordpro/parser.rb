require 'treetop'
require 'chordpro/node_extensions'

module Chordpro
  class Parser
    class ParseError < Exception
    end

    Treetop.load(File.expand_path('../sexp_parser.treetop', __FILE__))
    @@parser = SexpParser.new

    def self.parse(data)
      tree = @@parser.parse(data)
      raise ParseError, "Parse error at offset: #{@@parser.index}" if(tree.nil?)
      clean_tree(tree)
    end

    def self.clean_tree(root_node)
      return if(root_node.elements.nil?)
      root_node.elements.delete_if{|node| node.class.name == "Treetop::Runtime::SyntaxNode" }
      root_node.elements.each {|node| self.clean_tree(node) }
      root_node
    end
  end
end
