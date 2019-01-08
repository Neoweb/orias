require 'net/http'

module Orias
  # Dedicated to request handling to ORIAS API
  class Request < Base
    attr_reader :post
    attr_accessor :base_url, :body

    # Initialize an Orias::Request instance
    def initialize(attributes = {})
      super
      @base_url ||= 'https://ws.orias.fr/service?wsdl'
    end

    # Build the request to be sent
    def build!
      @post = Net::HTTP::Post.new(@base_url)
      @post.body = @body
      @post['Content-Type'] = 'application/xml'

      self
    end
  end
end
