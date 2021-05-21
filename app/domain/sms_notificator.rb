class SmsNotificator
  class << self
    def user_created(user)
      msg = ""
      Rails.logger.info("We send the most real SMS")
      sleep 1
    end
  end
end