class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  helper_method :login!, :logged_in?, :current_user, :authorized_user?, :logout!

  def login!
    session[:user_uuid] = @user.uuid
  end

  def logged_in?
    !!session[:user_uuid]
  end

  def current_user
    @current_user ||= User.find_by(uuid: session[:user_uuid]) if session[:user_uuid]
  end

  def authorized_user?
     @user == current_user
   end

   def logout!
     session.clear
   end
end
