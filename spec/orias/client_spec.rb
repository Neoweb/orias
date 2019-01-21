RSpec.describe Orias::Client, type: :class do
  describe '#build_request' do
    it 'returns an Orias::Request' do
      client = Orias::Client.new
      built_request = client.build_request!

      expect(built_request.class).to eq(Orias::Request)
    end
  end
end
