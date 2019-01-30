require 'orias/collection/base'

module Orias
  # Dedicated to Orias::Registration collections handling
  #
  class RegistrationCollection < CollectionBase
    def self.target_class
      Orias::Registration
    end

    def with_status(status_value)
      self.class.new(
        @all.select do |registration|
          registration.status == status_value
        end
      )
    end
  end
end
