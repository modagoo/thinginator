class SessionsController < ApplicationController

  skip_before_action :require_user, only: [:new, :create]

  def new
    log("Rendered sign-in form")
  end

  def create
    u = User.authenticate(session_params[:username], session_params[:password])
    if u
      user = User.find_or_create_by(username: session_params[:username])
      session[:user_id] = user.id
      log("Successful sign in '#{user.username}'")
      redirect_back_or_default(root_url, "Logged in")
      # redirect_to root_url
    else
      log("Invalid sign in attempt from '#{params[:username]}'")
      flash.now[:alert] = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    log("Sign out '#{current_user.username}'")
    session[:user_id] = nil
    redirect_to new_session_url, :notice => "Logged out"
  end

  private

  def session_params
    params.permit(:username, :password, :utf8, :authenticity_token)
  end

end
