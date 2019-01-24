require 'libxml_to_hash'

module Orias
  # Dedicated to search response handling
  #
  class Response < Base
    VALID_TYPES = [:intermediary_search].freeze

    attr_accessor :type, :raw_response, :raw_hash_response, :results

    # Initialize an Orias::Response instance
    def initialize(attributes = {})
      super
      self.process_raw_response!
    end

    def found
      return found_intermediaries if @type == :intermediary_search
      []
    end

    def not_found
      return found_intermediaries(false) if @type == :intermediary_search
      []
    end

    def found_intermediaries(v = true)
      @results.select do |result|
        result.found == v
      end
    end

    class << self
    end

    protected

    def process_raw_response!
      self.raw_hash_response = Hash.from_libxml(self.raw_response)['Envelope']['Body']

      if @type == :intermediary_search
        process_intermediary_search!
      else
        self
      end
    end

    private

    def process_intermediary_search!
      results_hash = self.raw_hash_response['intermediarySearchResponse']
      results_hash = results_hash['intermediaries']['intermediary']

      @results = results_hash.map do |h|
        Orias::Intermediary.new(h)
      end

      self
    end
  end
end
