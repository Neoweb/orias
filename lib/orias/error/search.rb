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
        op = 'All terms must have the right length for the Search type'
        op + " (#{Orias::Api::Search::VALID_INTERMEDIARIES_TYPE})."
      end
    end
  end
end
