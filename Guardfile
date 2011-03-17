guard 'rspec', :version => 1, :color => true, :bundler => false do
  watch('^spec/(.*)_spec.rb')
  watch('^lib/(.*)\.rb')                              { "spec" }
  watch('^spec/spec_helper.rb')                       { "spec" }
  watch('^app/(.*)')                                  { "spec" }
  watch('init.rb') { "spec" }
end
