require 'spec_helper'

describe Chordpro::Parser do
  before :all do
    @fixture = File.read(File.expand_path('../../fixtures/workspace.crd', __FILE__))
  end

  it 'parses a title' do
    directive = Chordpro::Parser.parse("{ title : foobar }").elements.first

    expect(directive).to be_kind_of(Sexp::Directive)
    expect(directive.name).to eq('title')
    expect(directive.value).to eq('foobar')
  end
end
