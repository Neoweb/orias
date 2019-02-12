# frozen_string_literal: true

require 'orias/base'

module Orias
  module Api
    # Dedicated to request handling to ORIAS API
    #
    class Client < Base
      attr_reader   :private_key
      attr_accessor :api_endpoint, :per_request

      # Initialize an Orias::Api::Client instance
      def initialize(attributes = {})
        super
        self.api_endpoint ||= Orias.configuration.api_endpoint
        self.per_request ||= Orias.configuration.per_request
        self.private_key ||= Orias.configuration.private_key
      end

      def private_key=(value)
        @private_key = value
        check_validations!
      end

      def check_validations!
        raise Orias::Error::ClientPrivateKeyInvalid unless valid_private_key?

        true
      end

      def valid_private_key?
        !private_key.to_s.empty?
      end
    end
  end
end
