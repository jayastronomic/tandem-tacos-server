class Api::V1::UsersController < ApplicationController
  before_action :find_user
  skip_before_action :find_user, only: %w(create)

  def create
    @user = User.new(user_params)
    if @user.save
      login!
      render json: @user
    else 
      render json: { status: 500, errors: @user.errors.full_messages }
    end 
  end

  def destroy
    @user.destroy
    render json: @user
  end

  def update
    @user.update(user_params)
    render json: @user
  end

  def show
    render json: @user
  end

  private 

  def find_user
    @user = User.find(params[:id])
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
