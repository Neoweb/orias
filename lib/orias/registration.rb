# frozen_string_literal: true

require 'orias/base'

module Orias
  # Dedicated to Orias registrations objects handling
  #
  class Registration < Base
    attr_accessor :raw, :category_name, :status, :subscribed,
                  :registration_date, :deletion_date, :collect_funds, :mandators

    # Initialize an Orias::Registration instance
    def initialize(attributes = {})
      @raw = attributes

      @category_name = @raw['categoryName']
      @status = @raw['status']
      @subscribed = @status == 'INSCRIT'
      @registration_date = @raw['registrationDate']
      @deletion_date = @raw['deletionDate']
      @collect_funds = @raw['collectFunds'] == 'true'

      raw_mandators = @raw.dig('mandators', 'mandator')
      @mandators = process_raw_mandators(raw_mandators)
    end

    private

    def process_raw_mandators(raw_mandators)
      raw_mandators = [raw_mandators] unless raw_mandators.is_a?(Array)

      mandators = raw_mandators.compact.map do |h|
        Orias::Mandator.new(h)
      end
      Orias::MandatorCollection.new(mandators)
    end

    class << self
    end
  end

  # Dedicated to Orias::Registration collections handling
  #
  class RegistrationCollection < CollectionBase
    def self.target_class
      Orias::Registration
    end
  end
end
