describe Item, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:price) }
  it { should validate_numericality_of(:stock_count) }
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
