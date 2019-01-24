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

    # Result collections

    [:found, :subscribed].each do |result_attr|

      define_method("#{result_attr}") do |attr_value = true|
        if @type == :intermediary_search
          return send("#{result_attr}_intermediaries".to_sym, attr_value)
        end

        []
      end

      define_method("not_#{result_attr}") do
        return send("#{result_attr}".to_sym, false)
      end

      define_method("#{result_attr}_intermediaries") do |attr_value = true|
        return send(:results).select do |result|
          result.send(result_attr) == attr_value
        end
      end

    end

    # Result collections methods

    [:found, :not_found].each do |collection|

      [:siren, :orias].each do |intermediary_attr|

        define_method("#{collection}_#{intermediary_attr}") do
          return send(collection).map do |intermediary|
            intermediary.send(intermediary_attr)
          end
        end

      end

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
      results_hash = [results_hash].flatten

      @results = results_hash.map do |h|
        Orias::Intermediary.new(h)
      end

      self
    end
  end
end
