class Item < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_count, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :for_api, -> { order('name ASC') }

  def price
    self.attributes['price'].to_f.round(2)
  end
end

# == Schema Information
#
# Table name: items
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  price       :decimal(, )      not null
#  stock_count :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
