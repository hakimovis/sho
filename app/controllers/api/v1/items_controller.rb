class Api::V1::ItemsController < Api::V1::AbstractController
  def index
    fields = %w[id name price stock_count]
    data = Item.for_api.decorate.map do |item|
                          {
                            id: item.id,
                            name: item.name,
                            price: item.price, # price returns as string to avoid e-notation like 0.2e1 or 1.1111111...
                            stock_count: item.stock_count
                          }
                        end
    render_success data
  end
end
