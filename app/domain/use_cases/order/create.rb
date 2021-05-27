module UseCases
  module Order
    class Create
      attr_accessor :user, :order_items, :errors

      delegate :valid?, to: :order

      def initialize(user, order_items)
        @user = user
        @order_items = order_items
        @errors = {}
      end

      def call
        order_items.each do |row|
          order.line_items.new(item_id: row[:id], count: row[:count].to_i)
        end

        order.waiting_for_payment! if order.valid?
      end

      def order
        @_order ||= ::Order.new(user: user)
      end
    end
  end
end