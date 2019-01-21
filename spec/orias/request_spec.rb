RSpec.describe Orias::Request, type: :class do
  describe '#build!' do
    it 'define the #post value' do
      request = Orias::Request.new
      request.build!

      expect(request.post).to_not eq(nil)
    end

    it 'uses the correct api_endpoint' do
      expected_endpoint = Faker::Internet.url
      request = Orias::Request.new(api_endpoint: expected_endpoint)
      request.build!

      expect(request.post.uri.to_s).to eq(expected_endpoint)
    end
  end
end
