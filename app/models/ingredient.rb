class Ingredient < ApplicationRecord
  belongs_to :recipe

  validates :name, presence: true
  validates :quantity, presence: true
  validates :name, length: { maximum: 35 }
end