module Orias
  # Base Orias class
  #
  class CollectionBase
    include Enumerable

    attr_accessor :all

    def self.target_class
    end

    # Initialize an Orias::Registration instance
    def initialize(all_elements = [])
      @all = all_elements
      check_collection_classes!
    end

    def each &block
      @all.each(&block)
    end

    protected

    def check_collection_classes!
      if self.class.target_class.nil?
        raise "Orias Collection - No target_class defined"
      end

      all_classes = all.map(&:class).uniq
      if !all_classes.empty? && all_classes != [self.class.target_class]
        raise "Orias Collection - wrong class included in all"
      end
    end
  end
end
