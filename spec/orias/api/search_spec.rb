# frozen_string_literal: true

RSpec.describe Orias::Api::Search, type: :class do
  valid_private_key = 'VALIDKEY'
  valid_client = Orias::Api::Client.new(private_key: valid_private_key)
  valid_search = Orias::Api::Search.new(client: valid_client)

  valid_types = Orias::Api::Search::VALID_TYPES
  valid_type_key = Orias::Api::Search::VALID_TYPES.keys.sample
  valid_type_values = (0..5).map do |i|
    Faker::Number.number(valid_types[valid_type_key])
  end

  # client
  describe '#client' do
    context 'when no client is submitted on initialization' do
      it 'raises a ClientPrivateKeyInvalid Error' do
        expected_error = Orias::Error::ClientPrivateKeyInvalid

        expect { Orias::Api::Search.new }.to raise_error(expected_error)
      end
    end
  end

  # find_by_orias
  describe '#find_by_orias' do
    it 'returns an Orias::Response' do
    end
  end

  # raw_body
  describe '#raw_body' do
    it 'returns the correct body' do
      random_content = 'This is a content.'

      xmlns_url = 'http://schemas.xmlsoap.org/soap/envelope/'

      expected_body = "<soapenv:Envelope xmlns:soapenv=\"#{xmlns_url}\">"
      expected_body += "<soapenv:Body>#{random_content}</soapenv:Body>"
      expected_body += '</soapenv:Envelope>'

      expect(valid_search.raw_body(random_content)).to eq(expected_body)
    end
  end

  # find_by
  describe '#find_by' do
    context 'when no client is submitted on initialization' do
      it 'returns a response' do
        pending('Stub API response.')
        # expect(valid_search.find_by(valid_type_key, valid_type_values)).to(
        #   be_a(Orias::Api::Response)
        # )
      end
    end
  end
end
