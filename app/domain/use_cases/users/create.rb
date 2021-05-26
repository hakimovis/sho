module UseCases
  module Users
    class Create
      attr_reader :attrs, :user

      def initialize(attrs)
        @attrs = attrs
      end

      def call
        result = user.save
        return false unless result

        UseCases::Users::Notificator.new(user).user_created

        true
      end

      def user
        @user ||= User.new(attrs)
      end

      def ok?
        user.persisted?
      end
    end
  end
end
