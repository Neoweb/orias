RSpec.describe Orias::Request, type: :class do
  describe '#api_endpoint' do
    it 'has a default value' do
      request = Orias::Request.new

      expect(request.api_endpoint).to_not eq(nil)
    end
  end

  describe '#build' do
    it 'define the #post value' do
      request = Orias::Request.new
      request.build!

      expect(request.post).to_not eq(nil)
    end
  end
end
