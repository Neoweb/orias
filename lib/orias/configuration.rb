module Orias
  # Dedicated to configuration management
  class Configuration < Base
    attr_accessor :private_key

    # Initialize an Orias::Configuration instance
    def initialize(attributes = {})
      super
    end
  end
end
