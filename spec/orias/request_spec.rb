RSpec.describe Orias::Request, type: :class do
  describe '#base_url' do
    it 'has a default value' do
      request = Orias::Request.new

      expect(request.base_url).to_not eq(nil)
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
