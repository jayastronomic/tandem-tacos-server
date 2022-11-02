class Recipe < ApplicationRecord
  include MeiliSearch::Rails
  belongs_to :user, optional: true, foreign_key: 'uuid'
  has_many :ingredients, dependent: :destroy
  has_one_attached :image

  validates :name, :directions, presence: true
  validates :name, length: { maximum: 200 }

  meilisearch do
    attributes :name
    attributes :restrictions
    attributes :name
    attributes :ingredients do
      ingredients.pluck(:name, :quantity)
    end
    # all attributes will be sent to Meilisearch if block is left empty
    displayed_attributes [:name, :restrictions, :ingredients]
    searchable_attributes [:name, :ingredients ]
    filterable_attributes [:restrictions]
  end
end