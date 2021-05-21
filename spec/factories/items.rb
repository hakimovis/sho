FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "item_#{n}" }
    sequence(:price) { |n| n + Math.sqrt(n).round(2) }
    sequence(:stock_count) { |n| n * 2 }
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
