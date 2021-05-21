FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "John_#{n}" }
    sequence(:email) { |n| "john_#{n}@localhost" }
    sequence(:phone) { |n| (79000000000 + n).to_s }
    sequence(:payment_data) { |n| "card_num_#{n}" }
  end
end

# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  name         :string
#  phone        :string
#  email        :string
#  payment_data :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
