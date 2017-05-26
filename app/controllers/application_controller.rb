class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #if you need a method availble to all controllers and views, define it in this controller and turn it into a helper_method with the `helper_method` method

  def user_signed_in?
    session[:user_id].present?
  end

  #👇 makes the method above available to all my views
  helper_method :user_signed_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if user_signed_in?
  end
  helper_method :current_user #, :user_signed_in?
end
