describe User do
  describe "validations" do
    subject { User.new }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
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
