require 'orias/collection/base'

module Orias
  # Dedicated to Orias::Registration collections handling
  #
  class RegistrationCollection < CollectionBase
    def self.target_class
      Orias::Registration
    end
  end
end
