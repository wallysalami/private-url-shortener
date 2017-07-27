class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  def index
    if current_user == nil
      redirect_to '/login'
    else
      redirect_to '/my-urls'
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def check_logged_user
    redirect_to '/login' unless current_user
  end
end
