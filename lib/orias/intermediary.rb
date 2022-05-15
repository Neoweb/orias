# frozen_string_literal: true

require 'orias/base'

module Orias
  # Dedicated to Orias intermediaries objects handling
  #
  class Intermediary < Base
    attr_accessor :raw, :found, :siren, :orias, :denomination, :registrations

    alias registration_number orias

    # Initialize an Orias::Intermediary instance
    def initialize(attributes = {})
      @raw = attributes

      base = @raw['informationBase'] || {}

      @found = base['foundInRegistry'] == 'true'
      @siren = base['siren']
      @orias = base['registrationNumber']
      @denomination = base['denomination']

      raw_registrations = @raw.dig('registrations', 'registration')
      @registrations = process_raw_registrations(raw_registrations)
    end

    def subscribed
      @registrations.where(status: 'INSCRIT').any?
    end

    def registrations_with_status(status_value)
      @registrations.select do |registration|
        registration.status == status_value
      end
    end

    private

    def process_raw_registrations(raw_registrations)
      raw_registrations = [raw_registrations] unless raw_registrations.is_a?(Array)

      registrations = raw_registrations.compact.map do |h|
        Orias::Registration.new(h)
      end
      Orias::RegistrationCollection.new(registrations)
    end

    class << self
    end
  end

  # Dedicated to Orias::Intermediary collections handling
  #
  class IntermediaryCollection < CollectionBase
    def self.target_class
      Orias::Intermediary
    end
  end
end
