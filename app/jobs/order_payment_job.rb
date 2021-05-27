class OrderPaymentJob < ApplicationJob
  queue_as :payments_processing

  def perform(order_id)
    @order = Order.find_by order_id
    return unless @order

    UseCases::Order::PaymentProcessor.new(@order).call
  end

end
