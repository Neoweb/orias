module Orias
  # Dedicated to Orias registrations objects handling
  #
  class Registration < Base
    attr_accessor :raw, :category_name, :status, :subscribed,
                  :registration_date, :deletion_date, :collect_funds, :mandators

    # Initialize an Orias::Registration instance
    def initialize(attributes = {})
      @raw = attributes

      @category_name = @raw.dig('categoryName')
      @status = @raw.dig('status')
      @subscribed = @status == 'INSCRIT'
      @registration_date = @raw.dig('registrationDate')
      @deletion_date = @raw.dig('deletionDate')
      @collect_funds = @raw.dig('collectFunds') == 'true'

      raw_mandators = @raw.dig('mandators', 'mandator')
      @mandators = process_raw_mandators(raw_mandators)
    end

    private

    def process_raw_mandators(raw_mandators)
      raw_mandators = [raw_mandators] unless raw_mandators.is_a?(Array)

      mandators = raw_mandators.compact.map do |h|
        Orias::Mandator.new(h)
      end
      Orias::MandatorCollection.new(mandators)
    end

    class << self
    end
  end
end
