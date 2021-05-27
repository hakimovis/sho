class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates :count, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validate :item_presence_validation
  validate :item_availability_validation

  def item_presence_validation
    errors.add :formalized, :not_found unless item
  end

  def item_availability_validation
    return unless item

    errors.add :formalized, :shortage unless item.stock_count >= count
  end

  def amount
    item.price * count
  end
end

# == Schema Information
#
# Table name: line_items
#
#  id         :bigint           not null, primary key
#  count      :integer
#  item_id    :integer
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
