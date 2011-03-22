guard 'rspec', :version => 1, :bundler => false do
  watch('^spec/(.*)_spec.rb')
  watch('^lib/(.*)\.rb')                              { "spec" }
  watch('^spec/spec_helper.rb')                       { "spec" }
  watch('^app/(.*)')                                  { "spec" }
  watch('init.rb') { "spec" }
end
