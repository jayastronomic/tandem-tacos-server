class Api::V1::UsersController < ApplicationController
  before_action :find_user
  skip_before_action :find_user, only: %w(create)

  def create
    @user = User.new(user_params)
    @user.uuid = SecureRandom.uuid
    if @user.save
      login!
      render json: @user, logged_in: logged_in?, status: :created
    else 
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end 
  end

  def destroy
    @user.destroy
    render json: @user, status: 200
  end

  def update
    if @user.update(user_params)
      render json: @user, status: 200
    else
      render json: { errors: @user.errors.full_messages, invalid_data: @user.invalid? }, status: 422
    end
  end

  def show
    render json: @user, status: 200
  end

  private 

  def find_user
    @user = User.find_by(uuid: params[:uuid])
  end

  def user_params
    params.require(:user).permit(
      :name,
      :username,
      :email,
      :password,
      :password_confirmation,
      :avatar
    ) 
  end
end
