module Orias
  # Base Orias class
  #
  class Base
    def initialize(attributes = {})
      _assign_attributes(attributes)
    end

    private

    def _assign_attributes(attributes)
      attributes.each do |key, value|
        _assign_attribute(key, value)
      end
    end

    def _assign_attribute(key, value)
      setter = :"#{key}="
      raise UnknownAttributeError.new(self, key) unless respond_to?(setter)

      public_send(setter, value)
    end
  end
end
