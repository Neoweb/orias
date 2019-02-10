require 'libxml_to_hash'

require 'orias/version'
require 'orias/api'
require 'orias/error'

require 'orias/intermediary'
require 'orias/registration'
require 'orias/mandator'

# Top-level of the orias ruby gem.
#
module Orias
  class << self
    attr_writer :configuration
  end

  # Orias::Api::Configuration instance accessor
  def self.configuration
    @configuration ||= Api::Configuration.new
  end

  # Orias::Api::Configuration instance builder
  def self.configure
    yield(configuration)
  end
end
