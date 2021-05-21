class SmsNotificator
  class << self
    def user_created(user)
      msg = "User created at SHO: #{user.short_info_str}"
      Rails.logger.info("We send the most real SMS")
      sleep 1
    end
  end
end