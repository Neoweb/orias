# frozen_string_literal: true

module Orias
  module Error
    # SearchTermsEmpty Error
    #
    class SearchTermsEmpty < RuntimeError
      def message
        'You must at least submit one term to build a valid search.'
      end
    end

    # SearchTypeInvalid Error
    #
    class SearchTypeInvalid < RuntimeError
      def message
        'Submitted type of search is not valid.'
      end
    end

    # WrongSearchTermLength Error
    #
    class WrongSearchTermLength < RuntimeError
      def message
        op = 'All terms must have the right length of numbers '
        op + "for the Search type (#{Orias::Api::Search::VALID_TYPES})."
      end
    end
  end
end
