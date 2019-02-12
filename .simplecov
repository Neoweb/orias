require 'simplecov-console'

SimpleCov.formatter = SimpleCov::Formatter::Console
# SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter

SimpleCov.start do
  @filters = []

  track_files 'lib/**/*.rb'

  add_filter 'spec'
  add_filter 'lib/orias/error'
  add_filter 'lib/orias/api.rb'
end
