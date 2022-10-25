class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar
  has_many :recipes, dependent: :destroy

  validates :name, :username, :email, presence: true 
  validates :username, :email, uniqueness: true 
  validates :username, format: { with: /\A[a-zA-Z0-9\-_]+\z/ }
  validates :name, length: { in: 1..100 }
  validates_length_of :username, minimum: 1, maximum: 32
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
