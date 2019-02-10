require 'orias/base'

module Orias
  module Api
    # Dedicated to request handling to ORIAS API
    #
    class Client < Base
      attr_accessor :api_endpoint, :per_request, :private_key

      # Initialize an Orias::Api::Client instance
      def initialize(attributes = {})
        super
        @api_endpoint ||= Orias.configuration.api_endpoint
        @per_request ||= Orias.configuration.per_request
        @private_key ||= Orias.configuration.private_key

        check_validations!
      end

      def check_validations!
        no_pvt_key_error = 'Orias::Client - private_key is not valid.'
        raise no_pvt_key_error unless valid_private_key?

        true
      end

      def valid_private_key?
        !@private_key.to_s.empty?
      end
    end
  end
end
