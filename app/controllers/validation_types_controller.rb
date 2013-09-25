class ValidationTypesController < ApplicationController
  before_action :require_superuser
  before_action :set_validation_type, only: [:show, :edit, :update, :destroy]

  # GET /validation_types
  # GET /validation_types.json
  def index
    @validation_types = ValidationType.all
  end

  # GET /validation_types/1
  # GET /validation_types/1.json
  def show
  end

  # GET /validation_types/new
  def new
    @validation_type = ValidationType.new
  end

  # GET /validation_types/1/edit
  def edit
  end

  # POST /validation_types
  # POST /validation_types.json
  def create
    @validation_type = ValidationType.new(validation_type_params)
    @validation_type.user = current_user
    respond_to do |format|
      if @validation_type.save
        format.html { redirect_to @validation_type, notice: 'Validation type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @validation_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @validation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /validation_types/1
  # PATCH/PUT /validation_types/1.json
  def update
    respond_to do |format|
      if @validation_type.update(validation_type_params)
        format.html { redirect_to @validation_type, notice: 'Validation type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @validation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /validation_types/1
  # DELETE /validation_types/1.json
  def destroy
    @validation_type.destroy
    respond_to do |format|
      format.html { redirect_to validation_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_validation_type
      @validation_type = ValidationType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def validation_type_params
      params.require(:validation_type).permit(:name, :friendly_name, :help)
    end
end
