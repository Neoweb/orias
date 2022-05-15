# frozen_string_literal: true

require 'net/http'
require 'orias/base'

module Orias
  module Api
    # Dedicated to request handling to ORIAS API
    #
    class Request < Base
      attr_reader   :http, :post, :uri
      attr_accessor :api_endpoint, :body

      # Initialize an Orias::Api::Request instance
      def initialize(attributes = {})
        super
        self.api_endpoint ||= Orias.configuration.api_endpoint
      end

      # Build the request to be sent
      def build!
        @uri = URI(self.api_endpoint)

        @post = Net::HTTP::Post.new(uri)
        @post.body = body
        @post['Content-Type'] = 'application/xml'

        @http = Net::HTTP.new(uri.host, uri.port)
        @http.use_ssl = true
        @http.read_timeout = 600

        self
      end

      # Send the built request
      def send!
        build! unless @post && @http
        @response = @http.request(@post)
        @response
      end

      # Return or set #response if not already set
      def response
        @response || send!
      end
    end
  end
end
