module Payment
  class DefaultProvider
    def self.call(payment_data, amount)
      self.new(payment_data, amount).call
    end

    def initialize(payment_data, amount)
      @payment_data = payment_data
      @amount = amount
    end

    def call
      # Requesting payment provider
      true
    end
  end
end