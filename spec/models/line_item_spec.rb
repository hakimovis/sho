require 'rails_helper'

RSpec.describe LineItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
