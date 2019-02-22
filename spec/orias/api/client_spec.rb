# frozen_string_literal: true

RSpec.describe Orias::Api::Client, type: :class do
  # private_key

  describe '#private_key' do
    context 'when a private_key is defined in the current Configuration' do
    end

    context 'when no private_key is defined in the current Configuration' do
      context 'when the Client is not initialized with a private_key' do
        it 'raises a ClientPrivateKeyInvalid Error' do
          expected_error = Orias::Error::ClientPrivateKeyInvalid

          expect { Orias::Api::Client.new }.to raise_error(expected_error)
        end
      end
    end
  end

  # private_key=

  describe '#private_key=' do
    it 'set the #private_key value' do
      valid_key = Faker::Number.number(20)

      client = Orias::Api::Client.new(private_key: 'tmp')
      client.private_key = valid_key

      expect(client.private_key).to eq(valid_key)
    end
  end

  # valid_private_key?

  describe '#valid_private_key?' do
    context 'when the defined private_key is valid' do
      client = Orias::Api::Client.new(private_key: 'VALIDKEY')

      it 'returns true' do
        expect(client.valid_private_key?).to eq(true)
      end
    end

    context 'when the defined private_key is not valid' do
      it 'raises a ClientPrivateKeyInvalid Error' do
        expected_error = Orias::Error::ClientPrivateKeyInvalid

        expect { Orias::Api::Client.new(private_key: nil) }.to(
          raise_error(expected_error)
        )
      end
    end
  end
end
