class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]

  # GET /collections
  # GET /collections.json
  def index
    @collections = Collection.all
  end

  # GET /collections/1
  # GET /collections/1.json
  def show
  end

  # GET /collections/new
  def new
    @collection = Collection.new
  end

  # GET /collections/1/edit
  def edit
  end

  # POST /collections
  # POST /collections.json
  def create
    # raise params.inspect
    @collection = Collection.new(collection_params)

    respond_to do |format|
      if @collection.save
        format.html { redirect_to collections_path, notice: 'Collection was successfully created.' }
        format.json { render action: 'show', status: :created, location: @collection }
      else
        format.html { render action: 'new' }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collections/1
  # PATCH/PUT /collections/1.json
  def update
    # raise params.inspect
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to collections_path, notice: 'Collection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.json
  def destroy
    if @collection.things.any?
      redirect_to collections_path, alert: 'ERROR: cannot delete collection unless it is empty'
    else
      @collection.destroy
      respond_to do |format|
        format.html { redirect_to collections_url }
        format.json { head :no_content }
      end
    end
  end

  private
  def set_collection
    @collection = Collection.find(params[:id])
  end

  def collection_params
    params.require(:collection).permit(:name, :slug, properties_attributes: [:id, :name, :slug, :data_type_id, :help, :_destroy, validations_attributes: [:value, :validation_type_id, :id, :_destroy]])
  end
end
