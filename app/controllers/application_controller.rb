class ApplicationController < ActionController::Base
  before_action :require_user
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :redirect_back_or_default, :admin?, :superuser?

  def store_location
    session[:return_to] = request.fullpath if request.fullpath.match(/(\.js)/).nil?
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    unless current_user
      store_location
      respond_to do |format|
        format.html { redirect_to new_session_url, notice: "Please sign in" }
        format.js   { render :text => "Your session has expired, please <a href='#{new_session_url}'>login again</a>" }
      end
    end
  end

  def require_superuser
    redirect_to root_url, alert: "You are not allowed to do that" unless superuser?
  end

  def require_admin
    redirect_to root_url, alert: "You are not allowed to do that" unless admin?
  end

  def superuser?
    current_user.try(:superuser?)
  end

  def admin?
    superuser? or current_user.try(:admin?)
  end

end
