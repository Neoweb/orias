# frozen_string_literal: true

require 'orias/base'

module Orias
  module Api
    # Dedicated to configuration management
    #
    class Configuration < Base
      DEFAULT_API_ENDPOINT = 'https://ws.orias.fr/service?wsdl'
      DEFAULT_PER_REQUEST = 1000

      attr_accessor :private_key, :api_endpoint, :per_request

      # Initialize an Orias::Api::Configuration instance
      def initialize(attributes = {})
        super
        self.api_endpoint ||= DEFAULT_API_ENDPOINT
        self.per_request ||= DEFAULT_PER_REQUEST
      end
    end
  end
end
