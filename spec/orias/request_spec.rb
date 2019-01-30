RSpec.describe Orias::Api::Request, type: :class do
  describe '#build!' do
    endpoint = Faker::Internet.url
    uri_endpoint = URI(endpoint)
    request = Orias::Api::Request.new(api_endpoint: endpoint)
    request.build!

    it 'define the #post value' do
      expect(request.post).to_not eq(nil)
    end

    it 'uses the correct api_endpoint' do
      expect(request.post.uri.to_s).to eq(endpoint)
    end

    it 'set a correct value for #uri' do
      expect(request.uri).to eq(uri_endpoint)
    end
  end

  describe '#response' do
    context 'when #body is valid' do
    end

    context 'when #body is empty' do
      request = Orias::Api::Request.new(body: nil)
      response = request.response

      it 'returns an HTTPInternalServerError' do
        expect(response).to be_a_kind_of(Net::HTTPInternalServerError)
      end
    end
  end
end
