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
      unless raw_mandators.is_a?(Array)
        raw_mandators = [raw_mandators]
      end

      @mandators = raw_mandators.compact.map do |h|
        Orias::Mandator.new(h)
      end
    end

    private

    class << self
    end
  end

  # Dedicated to Orias::Registration collections handling
  #
  class RegistrationCollection < CollectionBase
    def self.target_class
      Orias::Registration
    end

    def with_status(status_value)
      self.class.new(
        @all.select do |registration|
          registration.status == status_value
        end
      )
    end
  end
end
