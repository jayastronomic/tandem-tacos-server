class Api::V1::IngredientsSerializer < ActiveModel::Serializer
  attributes :uuid, :name, :quantity, :preparation
end
