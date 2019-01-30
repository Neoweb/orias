module Orias
  # Base Orias class
  #
  class CollectionBase
    include Enumerable

    attr_accessor :all

    def self.target_class; end

    # Initialize an Orias::Registration instance
    def initialize(all_elements = [])
      @all = all_elements
      check_collection_classes!
    end

    def each(&block)
      @all.each(&block)
    end

    def where(attributes = {})
      self.class.new(
        @all.reject do |element|
          attributes.map do |key, expected_value|
            where_element_attribute(element, key, expected_value)
          end.include?(false)
        end
      )
    end

    def where_element_attribute(element, key, value)
      return element.send(key).where(value).count >= 1 if value.is_a?(Hash)

      value = [value] unless value.is_a?(Array)
      value.include?(element.send(key.to_sym))
    end

    class << self
      def merge(instances)
        new(instances.map(&:all).flatten.compact)
      end
    end

    protected

    def check_collection_classes!
      if self.class.target_class.nil?
        raise 'Orias Collection - No target_class defined'
      end

      unless all_classes_valid?
        raise 'Orias Collection - wrong class included in all'
      end

      true
    end

    def all_classes
      all.map(&:class).uniq
    end

    def all_classes_valid?
      all_classes.empty? || all_classes == [self.class.target_class]
    end
  end
end