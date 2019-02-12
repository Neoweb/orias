require 'simplecov-console'
SimpleCov.formatter = SimpleCov::Formatter::Console

SimpleCov.start do
  add_filter 'spec'
end
