class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :name, :username, :email, :logged_in
  has_many :recipes, serializer: Api::V1::RecipeSerializer

  def logged_in
    @instance_options[:logged_in]
  end
end
