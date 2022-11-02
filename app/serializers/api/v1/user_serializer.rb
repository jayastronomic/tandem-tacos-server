class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :uuid, :name, :username, :email, :logged_in

  def logged_in
    @instance_options[:logged_in]
  end
end
