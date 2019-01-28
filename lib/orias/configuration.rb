module Orias
  # Dedicated to configuration management
  #
  class Configuration < Base
    DEFAULT_API_ENDPOINT = 'https://ws.orias.fr/service?wsdl'.freeze
    DEFAULT_PER_REQUEST = 1000.freeze

    attr_accessor :private_key, :api_endpoint, :per_request

    # Initialize an Orias::Configuration instance
    def initialize(attributes = {})
      super
      @api_endpoint ||= DEFAULT_API_ENDPOINT
      @per_request ||= DEFAULT_PER_REQUEST
    end
  end
end
