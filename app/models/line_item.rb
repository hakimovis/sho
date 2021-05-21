class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates :count, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
