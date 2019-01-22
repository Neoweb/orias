require 'net/http'

module Orias
  # Dedicated to request handling to ORIAS API
  #
  class Request < Base
    attr_reader   :http, :post, :uri
    attr_accessor :api_endpoint, :body
    attr_writer   :private_key

    # Initialize an Orias::Request instance
    def initialize(attributes = {})
      super
      @api_endpoint ||= Orias.configuration.api_endpoint
      @private_key ||= Orias.configuration.private_key
    end

    # Build the request to be sent
    def build!
      @uri = URI(@api_endpoint)

      @post = Net::HTTP::Post.new(uri)
      @post.body = @body
      @post['Content-Type'] = 'application/xml'

      @http = Net::HTTP.new(uri.host, uri.port)
      @http.use_ssl = true

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
