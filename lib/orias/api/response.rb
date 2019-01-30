module Orias
  module Api
    # Dedicated to search response handling
    #
    class Response < Base
      VALID_TYPES = [:intermediary_search].freeze

      attr_accessor :type, :raw, :raw_hash, :results

      # Initialize an Orias::Api::Response instance
      def initialize(attributes = {})
        super
        process_raw_response! if results.nil?
        check_type
      end

      # Result collections

      %i[found subscribed].each do |result_attr|
        define_method(result_attr) do |attr_value = true|
          if @type == :intermediary_search
            return send("#{result_attr}_intermediaries".to_sym, attr_value)
          end

          []
        end

        define_method("not_#{result_attr}") do
          return send(result_attr, false)
        end

        define_method("#{result_attr}_intermediaries") do |attr_value = true|
          return send(:results).select do |result|
            result.send(result_attr) == attr_value
          end
        end
      end

      # Result collections methods

      %i[found not_found].each do |collection|
        %i[siren orias].each do |intermediary_attr|
          define_method("#{collection}_#{intermediary_attr}") do
            return send(collection).map do |intermediary|
              intermediary.send(intermediary_attr)
            end
          end
        end
      end

      class << self
        def merge(all)
          if all.map(&:type).uniq.compact.length != 1
            raise 'Orias::Api::Response -
              Error merging Orias::Api::Response collection.'
          end

          new(
            raw: all.map(&:raw),
            raw_hash: all.map(&:raw_hash),
            results: Orias::IntermediaryCollection.merge(all.map(&:results)),
            type: all.map(&:type).uniq.first
          )
        end
      end

      protected

      def process_raw_response!
        self.raw_hash = Hash.from_libxml(raw)['Envelope']['Body']

        if @type == :intermediary_search
          process_intermediary_search!
        else
          self
        end
      end

      def valid_type?
        VALID_TYPES.include?(type)
      end

      def check_type
        raise 'Orias::Api::Response - Wrong type.' unless valid_type?
      end

      private

      def process_intermediary_search!
        results_hash = raw_hash.dig('intermediarySearchResponse')
        results_hash = results_hash.dig('intermediaries', 'intermediary')
        raise 'Orias::Api::Response - API response error.' unless results_hash

        intermediaries = [results_hash].flatten.map do |h|
          Orias::Intermediary.new(h)
        end
        @results = Orias::IntermediaryCollection.new(intermediaries)

        self
      end
    end
  end
end
