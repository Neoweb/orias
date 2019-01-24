module Orias
  # Dedicated to Orias mandators objects handling
  #
  class Mandator < Base
    attr_accessor :raw, :siren, :denomination

    # Initialize an Orias::Mandator instance
    def initialize(attributes = {})
      @raw = attributes

      @siren = @raw.dig('siren')
      @denomination = @raw.dig('denomination')
    end

    private

    class << self
    end
  end
end
