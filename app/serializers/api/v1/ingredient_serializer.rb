class Api::V1::IngredientSerializer < ActiveModel::Serializer
  attributes :uuid, :name, :quantity, :preparation
end
