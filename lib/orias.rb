require 'orias/version'
require 'orias/configuration'

# Top-level of the orias ruby gem.
#
module Orias
  class << self
    attr_writer :configuration
  end

  # Orias::Configuration instance accessor
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Orias::Configuration instance builder
  def self.configure
    yield(configuration)
  end
end
