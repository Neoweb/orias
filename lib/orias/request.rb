require 'net/http'

module Orias
  # Dedicated to request handling to ORIAS API
  #
  class Request < Base
    attr_reader :post
    attr_accessor :api_endpoint, :body
    attr_writer :private_key

    # Initialize an Orias::Request instance
    def initialize(attributes = {})
      super
      @api_endpoint ||= Orias.configuration.api_endpoint
      @private_key ||= Orias.configuration.private_key
    end

    # Build the request to be sent
    def build!
      @post = Net::HTTP::Post.new(URI(@api_endpoint))
      @post.body = @body
      @post['Content-Type'] = 'application/xml'

      self
    end
  end
end
