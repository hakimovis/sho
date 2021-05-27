module UseCases
  module Order
    class PaymentProcessor
      attr_reader :order, :payment_provider

      def initialize(order, payment_provider = PaymentProvidersRepo.default_provider)
        @order = order
        @payment_provider = payment_provider
      end

      def call
        return unless order.waiting_for_payment?

        result = payment_provider.call(order.user.payment_data, order.total_amount)

        return notify_payment_failed && false unless result

        order.paid!
        notify_payment_received

        true
      end

      private

      def notify_payment_failed
        notificator.payment_failed
      end

      def notify_payment_received
        notificator.payment_received
      end

      def notificator
        @_notificator ||= UseCases::Users::Notificator.new(order.user)
      end
    end
  end
end
