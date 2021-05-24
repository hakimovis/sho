class Api::V1::CheckoutController < Api::V1::AbstractController
  rescue_from ActiveRecord::RecordNotFound do
    render_error :not_found
  end

  def create
    user = User.find(params.require(:user_id))
    items = params.require(:items)

    creator = UseCases::Order::Create.new(user, items)
    creator.call

    render_checkout_result(creator.order)
  end

  def render_checkout_result(order)
    order_data = compile_order_data(order)
    checkout_status = order.valid? ? :accepted : :declined

    result = {checkout_status: checkout_status, order: order_data}
    render_success(result)
  end

  def compile_order_data(order)
    items_data = order.line_items.map do |one|
      status = one.valid? ? :available : one.errors.details.dig(:formalized, 0, :error)
      {id: one.item_id, status: status}
    end.sort_by { |one| one[:id].to_i }

    {status: order.status, items: items_data}
  end
end