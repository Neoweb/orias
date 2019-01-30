require 'libxml_to_hash'

require 'orias/base'
require 'orias/version'

require 'orias/api/configuration'
require 'orias/api/request'
require 'orias/api/client'
require 'orias/api/search'
require 'orias/api/response'

require 'orias/intermediary'
require 'orias/registration'
require 'orias/mandator'

require 'orias/collection/base'
require 'orias/collection/intermediary'
require 'orias/collection/registration'
require 'orias/collection/mandator'

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
