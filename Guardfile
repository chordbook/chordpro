guard 'rspec', :cli => '--color' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/spec_helper.rb$})    { "spec" }
  watch(%r{^lib/(.+)\.rb$})           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/chordpro/(.+)\.treetop$}) { |m| "spec/chordpro/parser_spec.rb" }
end
