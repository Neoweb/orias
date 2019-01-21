module Orias
  # Dedicated to configuration management
  #
  class Configuration < Base
    DEFAULT_API_ENDPOINT = 'https://ws.orias.fr/service?wsdl'.freeze

    attr_accessor :private_key, :api_endpoint

    # Initialize an Orias::Configuration instance
    def initialize(attributes = {})
      super
      @api_endpoint ||= DEFAULT_API_ENDPOINT
    end
  end
end
