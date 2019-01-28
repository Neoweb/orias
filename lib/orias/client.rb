module Orias
  # Dedicated to request handling to ORIAS API
  #
  class Client < Base
    attr_accessor :api_endpoint, :per_request, :private_key

    # Initialize an Orias::Client instance
    def initialize(attributes = {})
      super
      @api_endpoint ||= Orias.configuration.api_endpoint
      @per_request ||= Orias.configuration.per_request
      @private_key ||= Orias.configuration.private_key
    end
  end
end
