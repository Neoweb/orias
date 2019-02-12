# frozen_string_literal: true

module Orias
  module Error
    # ResponseMergeImpossible Error
    #
    class ResponseMergeImpossible < RuntimeError
      def message
        'Error merging Orias::Api::Response collection.'
      end
    end

    # ResponseTypeInvalid Error
    #
    class ResponseTypeInvalid < RuntimeError
      def initialize(msg = nil)
        valid_type_list = Orias::Api::Response::VALID_TYPES.join(',')
        msg = "Response type \"#{msg}\" not valid. Must be included in :
          #{valid_type_list}."
        super
      end
    end

    # ResponseUnreadable Error
    #
    class ResponseUnreadable < RuntimeError
      def message
        'Orias API response unreadable.'
      end
    end
  end
end
