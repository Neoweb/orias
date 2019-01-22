require 'net/http'

module Orias
  # Dedicated to request handling to ORIAS API
  #
  class Client < Base
    attr_accessor :api_endpoint
    attr_writer :private_key

    # Initialize an Orias::Client instance
    def initialize(attributes = {})
      super
      @api_endpoint ||= Orias.configuration.api_endpoint
      @private_key ||= Orias.configuration.private_key
    end

    # Build a new Request
    def build_request
      request = Orias::Request.new(
        api_endpoint: @api_endpoint,
        private_key: @private_key
      )

      request.build!
    end
  end
end
