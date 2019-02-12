# frozen_string_literal: true

RSpec.describe Orias::Api::Configuration, type: :class do
  describe '#api_endpoint' do
    it 'has a default value of "https://ws.orias.fr/service?wsdl"' do
      config = Orias::Api::Configuration.new
      expect(config.api_endpoint).to eq('https://ws.orias.fr/service?wsdl')
    end
  end

  describe '#api_endpoint=' do
    it 'set the #api_endpoint value' do
      valid_url = Faker::Internet.url

      config = Orias::Api::Configuration.new
      config.api_endpoint = valid_url

      expect(config.api_endpoint).to eq(valid_url)
    end
  end

  describe '#private_key' do
    it 'has a default value of "nil"' do
      config = Orias::Api::Configuration.new
      expect(config.private_key).to eq(nil)
    end
  end

  describe '#private_key=' do
    it 'set the #private_key value' do
      valid_key = Faker::String.random(20)

      config = Orias::Api::Configuration.new
      config.private_key = valid_key

      expect(config.private_key).to eq(valid_key)
    end
  end
end
