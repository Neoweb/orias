# frozen_string_literal: true

module Orias
  module Error
    # Base Error class
    #
    class Base < RuntimeError
      def message
        '/no defined message/'
      end
    end
  end
end
