RSpec.describe Orias::Configuration, type: :class do
  describe 'attr_accessor : api_endpoint' do
    describe '#api_endpoint' do
      it 'has a default value of "https://ws.orias.fr/service?wsdl"' do
        config = Orias::Configuration.new
        expect(config.api_endpoint).to eq('https://ws.orias.fr/service?wsdl')
      end
    end

    describe '#api_endpoint=' do
      it 'set the #api_endpoint value' do
        valid_url = Faker::Internet.url

        config = Orias::Configuration.new
        config.api_endpoint = valid_url

        expect(config.api_endpoint).to eq(valid_url)
      end
    end
  end

  describe 'attr_accessor : api_endpoint' do
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
end
