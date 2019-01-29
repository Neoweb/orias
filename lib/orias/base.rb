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

  class CollectionBase
    attr_accessor :all

    def self.target_class
    end

    # Initialize an Orias::Registration instance
    def initialize(all_elements = [])
      @all = all_elements
      check_collection_classes!
    end

    def to_a
      all
    end

    def count
      all.length
    end

    protected

    def check_collection_classes!
      if self.class.target_class.nil?
        raise "Orias Collection - No target_class defined"
      elsif !all.map(&:class).uniq.empty? && all.map(&:class).uniq != [self.class.target_class]
        puts "#{all.map(&:class).uniq} != #{[self.class.target_class]} -> true"
        raise "Orias Collection - wrong class included in all"
      end
    end
  end
end
