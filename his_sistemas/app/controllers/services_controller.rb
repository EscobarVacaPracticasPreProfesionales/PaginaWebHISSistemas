class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy, :destroy_picture]

  # GET /services
  # GET /services.json
  def index
    @services = Service.all
  end

  # GET /services/1
  # GET /services/1.json
  def show
  end

  # GET /services/new
  def new
    @service = Service.new
  end

  # GET /services/1/edit
  def edit
    @pics = @service.pictures.as_json
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(service_params)

    respond_to do |format|
      if @service.save
        format.html { redirect_to @service, notice: t('.service_was_successfully_created') }
        format.json { render :index, status: :created, location: @service }
      else
        format.html { render :new }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    puts "**********"
    puts params[:pics].inspect
    puts "**********"
    respond_to do |format|
      updated_params=add_pictures(@service,service_params)
      if @service.update(updated_params)
        format.html { redirect_to @service, notice: t('.service_was_successfully_updated') }
        format.json { render :index, status: :ok, location: @service }
      else
        format.html { render :edit }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to services_url, notice: t('.service_was_successfully_destroyed') }
      format.json { head :no_content }
    end
  end

  def destroy_picture
    delete_picture(@service,params[:index].to_i)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:title, :description, :user_id, {pictures: []})
    end

    def add_more_images(new_images)
      images = @service.pictures # copy the old images 
      images += new_images # concat old images with new ones
      @service.images = images # assign back
    end
end
