class PaymentProvidersRepo
  def self.default
    Payment::DefaultProvider
  end
end