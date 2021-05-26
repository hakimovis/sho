module UseCases
  module Users
    class Notificator
      DEFAULT_NOTIFICATORS = [SmsNotificator, UserMailer, WebSocketNotificator]
      attr_reader :user, :notificators

      def initialize(user, notificators = DEFAULT_NOTIFICATORS)
        @user = user
        @notificators = notificators
      end

      def user_created
        call_notificators user, "User created at SHO: #{user.short_info_str}"
      end

      def payment_failed
        call_notificators user, "Your paiment failed"
      end

      def payment_received
        call_notificators user, "Your paiment received"
      end

      private

      def call_notificators(user, text)
        notificators.map { |one| one.call(user, text) }
      end
    end
  end
end