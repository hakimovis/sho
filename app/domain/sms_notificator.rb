class SmsNotificator
  class << self
    def call(user, text)
      send_sms(user.phone, text)
    end

    private

    def send_sms(msisdn, text)
      Rails.logger.info("Sending SMS with text #{text.inspect} to #{msisdn}")
      sleep 1
      true
    end
  end
end