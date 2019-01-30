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
        self.process_raw_response! if results.nil?
        self.check_type
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

      class << self
        def merge(instances)
          if instances.map(&:type).uniq.compact.length != 1
            raise 'Orias::Api::Response - Error merging Orias::Api::Response collection.'
          end

          self.new(
            raw: instances.map(&:raw),
            raw_hash: instances.map(&:raw_hash),
            results: instances.map(&:results).flatten,
            type: instances.map(&:type).uniq.first
          )
        end
      end

      protected

      def process_raw_response!
        self.raw_hash = Hash.from_libxml(self.raw)['Envelope']['Body']

        if @type == :intermediary_search
          process_intermediary_search!
        else
          self
        end
      end

      def check_type
        raise 'Orias::Api::Response - Wrong type.' unless VALID_TYPES.include?(type)
      end

      private

      def process_intermediary_search!
        begin
          results_hash = self.raw_hash['intermediarySearchResponse']
          results_hash = results_hash['intermediaries']['intermediary']
        rescue
          raise 'Orias::Api::Response - API response error.' unless results_hash
        end

        @results = [results_hash].flatten.map do |h|
          Orias::Intermediary.new(h)
        end

        self
      end
    end
  end
end
