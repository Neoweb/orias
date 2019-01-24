require 'orias/base'
require 'orias/version'
require 'orias/configuration'
require 'orias/request'
require 'orias/client'
require 'orias/search'
require 'orias/response'
require 'orias/intermediary'
require 'orias/registration'
require 'orias/mandator'

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
