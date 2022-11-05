class Recipe < ApplicationRecord
  include MeiliSearch::Rails
  include Rails.application.routes.url_helpers
  belongs_to :user, optional: true
  has_many :ingredients, dependent: :destroy
  has_one_attached :image

  validates :name, :directions, presence: true
  validates :name, length: { maximum: 200 }

  meilisearch do
    attributes :restrictions
    attributes :name
    attributes :uuid
    attributes :user_id
    attributes :user_username
    attributes :ingredients_quantities
    attributes :image_url
    attributes :image_exist
    attributes :ingredients do
      ingredients.pluck(:name)
    end
  

    # all attributes will be sent to Meilisearch if block is left empty
    displayed_attributes [:name, :restrictions, :ingredients, :uuid , :user_id, :user_username, :ingredients_quantities, :image_exist, :image_url]
    searchable_attributes [:name]
    filterable_attributes [:restrictions, :ingredients]
  end

  def user_username
    self.user.username if !!self.user
  end

  def ingredients_quantities
    self.ingredients.pluck(:quantity)
  end

  def image_url
    if image_exist then url_for(self.image) else false end
  end

  def image_exist
     self.image.attached?
  end
end