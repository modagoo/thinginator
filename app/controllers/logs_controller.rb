class LogsController < ApplicationController
  before_action :require_admin

  def index
    @logs = Log.order(created_at: :desc).paginate(:page => params[:page])
  end

end
