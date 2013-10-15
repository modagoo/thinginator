class UsersController < ApplicationController
  before_action :require_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if params[:user][:superuser] == "1" && (superuser? != true)
      format.html { redirect_to edit_user_path(@user), alert: "ERROR: You are not allowed to do that" and return }
      format.json { head :no_content }
    else
      respond_to do |format|
        if @useruser.save
          format.html { redirect_to users_path, notice: 'User was successfully created.' }
          format.json { render action: 'show', status: :created, location: @user }
        else
          format.html { render action: 'new' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if params[:user][:superuser] == "1" && (superuser? != true)
        format.html { redirect_to users_path, alert: "ERROR: You are not allowed to do that" and return }
        format.json { head :no_content }
      else
        if superuser? && params[:user][:username] == current_user.username && params[:user][:superuser] != "1"
          format.html { redirect_to @user, alert: "Cannot remove your own superuser status" and return }
          format.json { head :no_content }
        elsif admin? && params[:user][:username] == current_user.username && params[:user][:admin] != "1"
          format.html { redirect_to @user, alert: "Cannot remove your own admin status" and return }
          format.json { head :no_content }
        elsif @user.update(user_params)
          format.html { redirect_to users_path, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to users_url, :notice => "User was successfully deleted"}
        format.json { head :no_content }
      else
        format.html { redirect_to users_url, :alert => "ERROR: #{@user.errors[:base].join}"}
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:userame, :firstname, :lastname, :admin, :superuser)
    end
end
