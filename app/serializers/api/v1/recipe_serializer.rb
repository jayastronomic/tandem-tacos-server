class Api::V1::RecipeSerializer < ActiveModel::Serializer
  attributes :uuid, :name, :directions, :user_uuid, :restrictions
  has_many :ingredients, serializer: Api::V1::IngredientsSerializer

  def user_uuid
    object.user.uuid if !!object.user
  end
end
