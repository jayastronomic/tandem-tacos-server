class Api::V1::RecipeSerializer < ActiveModel::Serializer
  attributes :uuid, :name, :description, :tags, :ingredients
end
