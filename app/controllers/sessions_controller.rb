class SessionsController < ApplicationController

  skip_before_action :require_user, only: [:new, :create]

  def new
  end

  def create
    u = User.authenticate(session_params[:username], session_params[:password])
    if u
      user = User.find_or_create_by_username(session_params[:username])
      session[:user_id] = user.id
      # redirect_to redirect_back_or_default(root_url), :notice => "Logged in"
      redirect_to root_url
    else
      flash.now[:alert] = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_url, :notice => "Logged out"
  end

  private

  def session_params
    params.permit(:username, :password, :utf8, :authenticity_token)
  end

end
