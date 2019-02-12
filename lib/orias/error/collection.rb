# frozen_string_literal: true

module Orias
  module Error
    # CollectionInvalidOrderAttribute Error
    #
    class CollectionInvalidOrderAttribute < RuntimeError
      def initialize(msg = nil)
        msg = "Unknown attribute \"#{msg}\" for this order method."
        super
      end
    end

    # CollectionUndefinedTargetClass Error
    #
    class CollectionUndefinedTargetClass < RuntimeError
      def message
        'A target_class must be defined.'
      end
    end

    # CollectionMultipleClasses Error
    #
    class CollectionMultipleClasses < RuntimeError
      def message
        'A Collection must include only one Class.'
      end
    end
  end
end
