class Api::V1::RecipeSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :uuid, :name, :directions, :user_id, :restrictions, :user_uuid, :user_username, :image_exist, :image_url
  has_many :ingredients, serializer: Api::V1::IngredientSerializer

  def user_uuid
    object.user.uuid if !!object.user
  end

  def user_username
    object.user.username if !!object.user
  end

  def image_exist
    object.image.attached?
  end

  def image_url
    if image_exist then url_for(object.image) else false end
  end
end
