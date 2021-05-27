class ItemDecorator < Draper::Decorator
  delegate_all

  def price
    object.price.round(2)
  end
end
