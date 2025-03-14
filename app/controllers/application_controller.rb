class ApplicationController < ActionController::Base
  include Pundit::Authorization
  protect_from_forgery with: :exception

  before_action :set_locale
  def set_locale
    I18n.locale = ENV.fetch('LANGUAGE', "en" )
  end

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

  def page_title
    request.host
  end
end
