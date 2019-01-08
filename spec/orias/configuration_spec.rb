RSpec.describe Orias::Configuration, type: :module do
  describe '#private_key' do
    it 'has a default value of "nil"' do
      config = Orias::Configuration.new
      expect(config.private_key).to eq(nil)
    end
  end

  describe '#private_key=' do
    it 'set the #private_key value' do
      valid_key = Faker::String.random(20)

      config = Orias::Configuration.new
      config.private_key = valid_key

      expect(config.private_key).to eq(valid_key)
    end
  end
end
