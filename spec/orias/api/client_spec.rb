RSpec.describe Orias::Api::Client, type: :class do
  # private_key
  context 'when a private_key is defined is the current Configuration' do
  end

  context 'when no private_key is defined is the current Configuration' do
    context 'when the Client is not initialized with a private_key' do
      it 'raises a ClientPrivateKeyInvalid Error if ' do
        expected_error = Orias::Error::ClientPrivateKeyInvalid
        expect { Orias::Api::Client.new }.to raise_error(expected_error)
      end
    end
  end

  # private_key=

  describe '#private_key=' do
    it 'set the #private_key value' do
      valid_key = Faker::String.random(20)

      client = Orias::Api::Client.new(private_key: 'tmp')
      client.private_key = valid_key

      expect(client.private_key).to eq(valid_key)
    end
  end
end
