module Orias
  # Dedicated to configuration management
  class Configuration
    attr_accessor :private_key

    # Initialize an Orias::Configuration instance
    def initialize
      @private_key = nil
    end
  end
end
