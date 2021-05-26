class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items

  state_machine :status, initial: :draft do
    event :waiting_for_payment do
      transition :draft => :waiting_for_payment
    end

    event :paid do
      transition :waiting_for_payment => :ready_for_processing
    end

    event :processing_in_progress do
      transition :ready_for_processing => :in_progress
    end

    event :completed do
      transition :in_progress => :completed
    end

    event :awaiting_item_availability do
      transition :in_progress => :awaiting_item_availability
    end

    event :declined do
      transition all - [:completed, :declined] => :declined
    end
  end

  def total_amount
    line_items.map(&:amount).sum
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
