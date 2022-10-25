class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :name, :username, :email, :logged_in, :invalid_data

  def logged_in
    @instance_options[:logged_in]
  end

  def invalid_data
     @instance_options[:invalid_data]
  end
end
