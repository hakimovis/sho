class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items

  state_machine :status, initial: :new do
    event :completed do
      transition all => :completed
    end
  end

end

# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  user_id    :integer          not null
#  status     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
