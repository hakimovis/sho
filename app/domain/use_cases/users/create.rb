module UseCases
  module Users
    class Create
      attr_reader :attrs, :notificators, :user

      def initialize(attrs, notificators: [UserMailer])
        @attrs = attrs
        @notificators = notificators
      end

      def call
        result = user.save
        return false unless result

        notificators.each { |n| n.user_created(user) }
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
