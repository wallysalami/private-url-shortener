class SessionsController < ApplicationController

  def new
  end

  def create
    @current_user = User.find_by_username(params[:username])
    # If the user exists AND the password entered is correct.
    if @current_user && @current_user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = @current_user.id
      redirect_to '/my-urls'
    else
    # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def current_user
     @current_user ||= User.find_by(id: session[:user_id])
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end