class Recipe < ApplicationRecord
  belongs_to :user

  validates :name, :description, presence: true
  validates :name, length: { maximum: 200 }
end