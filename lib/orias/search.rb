module Orias
  # Dedicated to search request building
  #
  class Search < Base
    attr_accessor :api_endpoint
    attr_writer :private_key

    # Initialize an Orias::Search instance
    def initialize(attributes = {})
      super
      @api_endpoint ||= Orias.configuration.api_endpoint
      @private_key ||= Orias.configuration.private_key
    end

    def self.find_by_orias(orias); end

    def self.raw_find(raw_intermeds)
      xmlns = 'http://schemas.xmlsoap.org/soap/envelope/'

      body = "<soapenv:Envelope xmlns:soapenv=\"#{xmlns}\">"
      body += '<soapenv:Body>'
      body += '<intermediarySearchRequest xmlns="urn:gpsa:orias:ws.001">'
      body += "<user xmlns=\"\">#{@private_key}</user>"
      body += "<intermediaries xmlns=\"\">#{raw_intermeds}</intermediaries>"
      body + '</intermediarySearchRequest></soapenv:Body></soapenv:Envelope>'
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
