# frozen_string_literal: true

require 'orias/base'

module Orias
  module Api
    # Dedicated to search request building
    #
    class Search < Base
      VALID_TYPES = { siren: 9, registrationNumber: 8 }.freeze

      attr_accessor :client

      # Initialize an Orias::Api::Search instance
      def initialize(attributes = {})
        super
        self.client ||= Orias::Api::Client.new
      end

      # Alias for #find_by with an :orias type
      def find_by_orias(terms)
        find_by(:orias, terms)
      end

      # Alias for #find_by with an :siren type
      def find_by_siren(terms)
        find_by(:siren, terms)
      end

      # Request building for intermediarySearchRequest
      def find_by(type, terms)
        term_collections = [terms].flatten.each_slice(self.client.per_request)
        responses = term_collections.map do |term_collection|
          request = build_find_request(type, term_collection)

          Orias::Api::Response.new(
            type: :intermediary_search,
            raw: request.response.body
          )
        end

        Orias::Api::Response.merge(responses)
      end

      def build_find_request(type, term_collection)
        Orias::Api::Request.new(
          api_endpoint: self.client.api_endpoint,
          body: raw_find(raw_intermediaries(type, term_collection))
        ).build!
      end

      # Build the raw request body of a search
      def raw_body(content)
        xmlns_url = 'http://schemas.xmlsoap.org/soap/envelope/'

        output = "<soapenv:Envelope xmlns:soapenv=\"#{xmlns_url}\">"
        output += "<soapenv:Body>#{content}</soapenv:Body>"
        output + '</soapenv:Envelope>'
      end

      # Build the raw search request of a search
      def raw_find(raw_intermeds)
        output = '<intermediarySearchRequest xmlns="urn:gpsa:orias:ws.001">'
        output += "<user xmlns=\"\">#{self.client.private_key}</user>"
        output += "<intermediaries xmlns=\"\">#{raw_intermeds}</intermediaries>"
        output += '</intermediarySearchRequest>'

        raw_body(output)
      end

      # Build the raw intermediaries list of a search
      def raw_intermediaries(type, terms)
        raise Orias::Error::SearchTermsEmpty if terms.empty?

        type = Search.set_type(type, terms)
        terms = Search.set_terms(type, terms)

        terms.flatten.uniq.compact.map do |term|
          "<intermediary><#{type}>#{term}</#{type}></intermediary>\n"
        end.join
      end

      class << self
        # Check & Set the type for an intermediaries list
        def set_type(type, terms)
          type = :registrationNumber if type == :orias

          return type if VALID_TYPES.key?(type)

          lengths = terms.map(&:length).uniq
          length_type = VALID_TYPES.invert[lengths.first]

          unless lengths.length == 1 && length_type
            raise Orias::Error::SearchTypeInvalid
          end

          VALID_TYPES.invert[lgts.first]
        end

        # Check & Set an intermediaries list
        def set_terms(type, terms)
          terms.map! { |t| t.to_s.gsub(/\D/, '') }
          lengths = terms.map(&:length).uniq
          valid_length = VALID_TYPES[type]

          unless lengths.length == 1 && lengths.first == valid_length
            raise Orias::Error::WrongSearchTermLength
          end

          terms
        end
      end
    end
  end
end
