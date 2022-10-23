class Recipe < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :name, :description, presence: true
  validates :name, length: { maximum: 200 }
end