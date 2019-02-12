require 'simplecov'
require 'bundler/setup'
require 'orias'
require 'faker'
require 'simplecov-console'

# SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter

SimpleCov.profiles.define :gem do
  track_files 'lib/**/*.rb'

  add_group 'Api', 'lib/orias/api'

  add_filter 'spec'
  add_filter 'lib/orias/error'
  add_filter 'lib/orias/api.rb'
end

SimpleCov.start :gem

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
