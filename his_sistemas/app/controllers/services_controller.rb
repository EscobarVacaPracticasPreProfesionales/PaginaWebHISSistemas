class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy, :destroy_picture, :validate_before]
  before_action :require_admin, only: [:show, :edit, :update, :destroy, :destroy_picture]
  before_action :is_admin, only: [:index]
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
          flash[:errors] = nil
        else
          format.html { redirect_to edit_service_path(@service)}
          format.json { render :edit, status: :ok, location: @service }
          flash[:errors] = nil
        end
      else
        format.js
        format.json { render json: @service.errors, status: :unprocessable_entity }
        flash[:errors] = @service.errors.messages.as_json
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    @upictures=params[:update_pictures].to_s
    @bool=params[:back].to_s
    puts "********"
    puts @bool
    puts "********"
    updated_params=add_pictures(@service,service_params)
    respond_to do |format|
      if @service.update(updated_params)
        if @upictures=='false'
          format.html { redirect_to path(@bool,@service,services_url), notice: t('.service_was_successfully_updated') }
          format.json { render :show, status: :ok, location: @service }
          flash[:errors] = nil
        else
          format.js
          format.json { render :edit, status: :ok, location: @service }
          flash[:errors] = nil
        end
      else
        format.js
        format.json { render json: @service.errors, status: :unprocessable_entity }
        flash[:errors] = @service.errors.messages.as_json
      end
    end
  end

  def validate_before
    puts "ASHDJAHSEEEEEEEEEEEEEEOOOOOOOOOOOOO"
    @gg=true
    respond_to do |format|
      if @gg
        format.html { redirect_to "/", notice: t('.webo') }
      else
        format.js
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

    def require_admin
      admin_require(services_url)
    end

    def path(bool,model,model_url)
      if bool
        model_url
      else
        model
      end
    end
end
