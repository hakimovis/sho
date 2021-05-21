class User < ApplicationRecord
  validate :name, presence: true
  validate :email, presence: true
  validate :phone, presence: true
  validate :payment_data, presence: true
end
