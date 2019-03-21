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
  end

  # POST /services
  # POST /services.json
  def create
    @upictures=params[:update_pictures].to_s
    @service = Service.new(service_params)

    respond_to do |format|
      if @service.save
        if @upictures=='false'
          format.html { redirect_to @service, notice: t('.service_was_successfully_created') }
          format.json { render :show, status: :created, location: @service }
        else
          format.html { redirect_to edit_service_path(@service)}
          format.json { render :edit, status: :ok, location: @service }
        end
      else
        format.html { render :new }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    @upictures=params[:update_pictures].to_s
    updated_params=add_pictures(@service,service_params)
    
    respond_to do |format|
      if @service.update(updated_params)
        if @upictures=='false'
          format.html { redirect_to @service, notice: t('.service_was_successfully_updated') }
          format.json { render :show, status: :ok, location: @service }
        else
          format.js
          format.json { render :edit, status: :ok, location: @service }
        end
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
end
