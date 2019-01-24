module Orias
  # Dedicated to Orias intermediaries objects handling
  #
  class Intermediary < Base
    attr_accessor :raw, :found, :siren, :orias, :denomination, :registrations

    # Initialize an Orias::Intermediary instance
    def initialize(attributes = {})
      @raw = attributes

      base = @raw.dig('informationBase')

      @found = base.dig('foundInRegistry') == 'true'
      @siren = base.dig('siren')
      @orias = base.dig('registrationNumber')
      @denomination = base.dig('denomination')

      raw_registrations = @raw.dig('registrations', 'registration')
      unless raw_registrations.is_a?(Array)
        raw_registrations = [raw_registrations]
      end

      @registrations = raw_registrations.compact.map do |h|
        Orias::Registration.new(h)
      end
    end

    def registration_number
      orias
    end

    private

    class << self
    end
  end
end
