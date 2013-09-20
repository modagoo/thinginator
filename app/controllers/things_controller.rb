class ThingsController < ApplicationController
  before_action :set_thing, only: [:show, :edit, :update, :destroy]

  def test
  end

  def index
    @collections = Collection.all
  end

  def collection_index
    begin
      @collection = Collection.find_by_slug(params[:slug])
      if admin?
        @things = @collection.things
      else
        @things = current_user.things
      end
    rescue
      render :text => 'no such thing'
    end
    respond_to do |format|
      format.html { }
      format.json { render json: @things }
      format.xls  { }
    end
  end

  def show
  end

  # GET /things/new
  def new_thing
    if collection = Collection.find_by_slug(params[:slug].pluralize)
      @thing = Thing.new(collection: collection)
    else
      render text: "No collection"
    end
  end

  # GET /things/1/edit
  def edit
  end

  # POST /things
  # POST /things.json
  def create
    # raise params.inspect
    @thing = Thing.new(thing_params)
    @thing.user = current_user
    respond_to do |format|
      if @thing.save
        format.html { redirect_to collection_index_path(@thing.collection.slug), notice: "#{@thing.collection.name} was successfully created." }
        format.json { render action: 'show', status: :created, location: @thing }
      else
        format.html { render action: 'new_thing' }
        format.json { render json: @thing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /things/1
  # PATCH/PUT /things/1.json
  def update
    respond_to do |format|
      if @thing.update(thing_params)
        format.html { redirect_to collection_index_path(@thing.collection.slug), notice: 'Thing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @thing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /things/1
  # DELETE /things/1.json
  def destroy
    collection = @thing.collection
    @thing.destroy
    respond_to do |format|
      format.html { redirect_to collection_index_path(collection.slug) }
      format.json { head :no_content }
    end
  end

  private
  def set_thing
    @thing = Thing.find(params[:id])
  end

  def thing_params
    # params.require(:thing).permit(:slug, :collection_id, :size, :colour, :description)
    params.require(:thing).permit!
  end

end
