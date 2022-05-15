# frozen_string_literal: true

require 'orias/base'

module Orias
  # Dedicated to Orias mandators objects handling
  #
  class Mandator < Base
    attr_accessor :raw, :siren, :denomination

    # Initialize an Orias::Mandator instance
    def initialize(attributes = {})
      @raw = attributes

      @siren = @raw['siren']
      @denomination = @raw['denomination']
    end

    class << self
    end
  end

  # Dedicated to Orias::Mandator collections handling
  #
  class MandatorCollection < CollectionBase
    def self.target_class
      Orias::Mandator
    end
  end
end
