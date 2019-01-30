RSpec.describe Orias do
  it 'has a version number' do
    expect(Orias::VERSION).not_to be nil
  end

  describe '#configure' do
    it 'build an Orias::Api::Configuration' do
      valid_key = Faker::String.random(20)

      Orias.configure do |conf|
        conf.private_key = valid_key
      end

      expect(Orias.configuration.private_key).to eq(valid_key)
    end
  end
end
