module Orias
  # Dedicated to search request building
  #
  class Search < Base
    VALID_INTERMEDIARIES_TYPE = { siren: 9, registrationNumber: 8 }.freeze

    attr_accessor :client

    # Initialize an Orias::Search instance
    def initialize(attributes = {})
      super
      @client ||= Orias::Client.new
    end

    # Alias for #find_by with an :orias type
    def find_by_orias(*terms)
      find_by(:orias, terms)
    end

    # Alias for #find_by with an :siren type
    def find_by_siren(*terms)
      find_by(:siren, terms)
    end

    # Request building for intermediarySearchRequest
    def find_by(type, terms)
      Orias::Request.new(
        api_endpoint: @client.api_endpoint,
        body: raw_find(raw_intermediaries(type, terms))
      ).build!
    end

    # Build the raw request body of a search
    def raw_body(body_content)
      xmlns_url = 'http://schemas.xmlsoap.org/soap/envelope/'

      output = "<soapenv:Envelope xmlns:soapenv=\"#{xmlns_url}\">"
      output += "<soapenv:Body>#{body_content}</soapenv:Body>"
      output + '</soapenv:Envelope>'
    end

    # Build the raw search request of a search
    def raw_find(raw_intermeds)
      content = '<intermediarySearchRequest xmlns="urn:gpsa:orias:ws.001">'
      content += "<user xmlns=\"\">#{@client.private_key}</user>"
      content += "<intermediaries xmlns=\"\">#{raw_intermeds}</intermediaries>"
      content += '</intermediarySearchRequest>'

      raw_body(content)
    end

    # Build the raw intermediaries list of a search
    def raw_intermediaries(type, terms)
      raise 'Orias::Search - You must at least submit one term.' if terms.empty?

      type = Search.set_type(type, terms)
      Search.check_terms(type, terms)

      terms.flatten.uniq.compact.map do |term|
        "<intermediary><#{type}>#{term}</#{type}></intermediary>\n"
      end.join
    end

    class << self
      # Check & Set the type for an intermediaries list
      def set_type(type, terms)
        type = :registrationNumber if type == :orias

        return type if VALID_INTERMEDIARIES_TYPE.key?(type)

        lgts = terms.map(&:length).uniq

        unless lgts.length == 1 && VALID_INTERMEDIARIES_TYPE.invert[lgts.first]
          raise "Orias::Search - Unknown Type Error (\"#{type}\")."
        end

        VALID_INTERMEDIARIES_TYPE.invert[lgts.first]
      end

      # Check an intermediaries list
      def check_terms(type, terms)
        lgts = terms.map(&:length).uniq
        valid_lgth = VALID_INTERMEDIARIES_TYPE[type]

        unless lgts.length == 1 && lgts.first == valid_lgth
          raise "Terms for \"#{type}\" must all have a length of #{valid_lgth}."
        end

        true
      end
    end
  end
end
