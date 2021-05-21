class UserMailer < ApplicationMailer
  def user_created(user)
    Rails.logger.info("Fake email about user creation: #{user.short_info_str}")
  end
end