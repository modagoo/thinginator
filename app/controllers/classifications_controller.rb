class ClassificationsController < ApplicationController

  before_action :set_classification, only: [:show, :edit, :update, :destroy, :new_property_fields]

  # GET /classifications
  # GET /classifications.json
  def index
    @classifications = Classification.all
  end

  # GET /classifications/1
  # GET /classifications/1.json
  def show
  end

  # GET /classifications/new
  def new
    @classification = Classification.new
  end

  def new_property_fields
    @classification.properties.build
    respond_to do |format|
      format.js { render partial: 'property', collection: @classification.properties }
    end
  end

  # GET /classifications/1/edit
  def edit
  end

  # POST /classifications
  # POST /classifications.json
  def create
    # raise params.inspect
    @classification = Classification.new(classification_params)

    respond_to do |format|
      if @classification.save
        format.html { redirect_to @classification, notice: 'Classification was successfully created.' }
        format.json { render action: 'show', status: :created, location: @classification }
      else
        format.html { render action: 'new' }
        format.json { render json: @classification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /classifications/1
  # PATCH/PUT /classifications/1.json
  def update
    respond_to do |format|
      if @classification.update(classification_params)
        format.html { redirect_to @classification, notice: 'Classification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @classification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classifications/1
  # DELETE /classifications/1.json
  def destroy
    @classification.destroy
    respond_to do |format|
      format.html { redirect_to classifications_url }
      format.json { head :no_content }
    end
  end

  private
  def set_classification
    @classification = Classification.find(params[:id])
  end

  def classification_params
    params.require(:classification).permit(:name, :slug, properties_attributes: [:name, :slug])
  end

end
