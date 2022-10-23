class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar
  has_many :recipes

  validates :name, :username, :email, presence: { strict: true }
  validates :username, :email, uniqueness: { strict: true }
  validates :username, format: { with: /\A[A-Za-z0-9_]+\z/ }
  validates :name, length: { in: 1..100 }
  validates :username, length: { in: 1..32 }
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
