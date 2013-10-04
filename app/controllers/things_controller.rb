class ThingsController < ApplicationController
  before_action :set_thing, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:all_the_things]

  def all_the_things
    @collections = Collection.all
    log("Downloaded all the things")
    respond_to do |format|
      format.xls  { }
    end
  end

  def download_file
    content_file = ContentFile.find(params[:id])
    if File.exists?(content_file.value.path)
      log("Downloaded '#{content_file.value.path}'")
      send_file content_file.value.path, type: content_file.value_content_type
    else
      log("ERROR: could not download '#{content_file.value.path}'")
      redirect_to things_path, alert: "ERROR: file does not exist"
    end
  end

  def index
    @collections = Collection.all
    log("Viewed collections")
  end

  # def collection_index
  #   begin
  #     @collection = Collection.find_by_slug(params[:slug])
  #     if admin?
  #       @things = @collection.things.paginate(:page => params[:page])
  #       log("Admin viewed collection '#{@collection.name}'")
  #     else
  #       @things = @collection.things.where(user: current_user).paginate(:page => params[:page])
  #       log("User viewed collection '#{@collection.name}'")
  #     end
  #   rescue
  #     render text: 'no such collection', status: 404
  #     log("Collection not found '#{params[:slug]}'")
  #   end
  #   respond_to do |format|
  #     format.html { }
  #     format.json { render json: @things }
  #     format.xls  {
  #       if admin?
  #         @things = @collection.things
  #       else
  #         @things = @collection.things
  #       end
  #     }
  #   end
  # end

  def collection_index
    @collection = Collection.find_by_slug(params[:slug].pluralize)
    c = @collection.id
    pagesize = SEARCH_PAGE_SIZE
    u = current_user.username
    p = params[:page]
    t = params[:slug]

    if p.blank?
      offset = 0
    else
      offset = pagesize * (p.to_i - 1)
    end
    r = Thing.search do
      query do
        string "*"
      end
      if t.present?
        filter :term, :collection => c
      end
      facet 'collection_name', :global => false do
        terms :type,
        size: 999
      end
      from offset
      size pagesize
    end
    @things = r
  end

  def show
    log("Viewed thing ##{@thing.id}")
  end

  # GET /things/new
  def new_thing
    if collection = Collection.find_by_slug(params[:slug].pluralize)
      @thing = Thing.new(collection: collection)
      log("Rendered new thing form for collection '#{collection.name}'")
    else
      log("ERROR: no such collection ##{params[:slug]}")
      render text: "No collection"
    end
  end

  # GET /things/1/edit
  def edit
    log("Rendered edit thing form for ##{@thing.id}")
  end

  # POST /things
  # POST /things.json
  def create
    # raise params.inspect
    @thing = Thing.new(thing_params)
    @thing.user = current_user
    respond_to do |format|
      if @thing.save
        log("Successfully created new thing ##{@thing.id}")
        format.html { redirect_to collection_index_path(@thing.collection.slug), notice: "#{@thing.collection.name} was successfully created." }
        format.json { render action: 'show', status: :created, location: @thing }
      else
        log("ERROR: could not create new thing '#{@thing.errors.full_messages.join(', ')}'")
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
        log("Successfully updated thing ##{@thing.id}")
        format.html { redirect_to collection_index_path(@thing.collection.slug), notice: 'Thing was successfully updated.' }
        format.json { head :no_content }
      else
        log("ERROR: could not update thing ##{@thing.id} '#{@thing.errors.full_messages.join(', ')}'")
        format.html { render action: 'edit' }
        format.json { render json: @thing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /things/1
  # DELETE /things/1.json
  def destroy
    log("Destroying thing ##{@thing.id}")
    collection = @thing.collection
    @thing.destroy
    respond_to do |format|
      format.html { redirect_to collection_index_path(collection.slug) }
      format.json { head :no_content }
    end
  end

  private
  def set_thing
    begin
      @thing = Thing.find(params[:id])
    rescue
      log("ERROR: no such thing ##{params[:id]}")
      render text: "no such thing", status: 404
    end
  end

  def thing_params
    # params.require(:thing).permit(:slug, :collection_id, :size, :colour, :description)
    params.require(:thing).permit!
  end

end
