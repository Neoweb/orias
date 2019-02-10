module Orias
  module Error
    # ClientPrivateKeyInvalid Error
    #
    class ClientPrivateKeyInvalid < RuntimeError
      def message
        'The used private_key is not valid.'
      end
    end
  end
end
