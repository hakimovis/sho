class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 255 }, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :phone, presence: true, length: { maximum: 12 }, format: {with: /\A+?[78]9\d{9}\z/}
  validates :payment_data, presence: true

  def short_info_str
    %w[name email phone payment_data].map do |field|
      "#{field}: #{self.attributes[field]}"
    end.join("\n")
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
