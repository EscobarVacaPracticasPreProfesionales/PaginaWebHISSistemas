class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:show, :edit, :new, :update, :destroy, :destroy_picture]
  before_action :is_admin

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
    flash[:errors] = nil
    @@servicec = Service.new
    @@pictures= Picture.new
    @@servicec.picture=@@pictures
    @service=@@servicec
  end

  # GET /services/1/edit
  def edit
    flash[:errors] = nil
    @@pictures= Picture.new
    @@pictures.files=@service.picture.files
  end

  # POST /services
  # POST /services.json
  def create    
    if service_params['picture_attributes']
      if service_params['picture_attributes']['files']
        @@pictures.files+=service_params['picture_attributes']['files']
      end
    end
    if params[:update_pictures].to_s == "true"
      @@servicec.picture=@@pictures
      @service=@@servicec
      respond_to do |format|
        format.js { render 'images' }
        format.json { render :new, status: :ok, location: @service }
      end
      puts "=)=)=)=)=)=)=)=)"
    else
      @service = Service.new(service_params)
      @service.picture=@@pictures
      respond_to do |format|        
        if @service.save
          format.html { redirect_to @service, notice: t('.service_was_successfully_created') }
          format.json { render :show, status: :created, location: @service }
        else
          flash[:errors] = @service.errors.messages.as_json
          format.js { render 'form' }
          format.json { render json: @service.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    @upictures=params[:update_pictures].to_s
    if service_params['picture_attributes']
      if service_params['picture_attributes']['files']
        @@pictures.files+=service_params['picture_attributes']['files']
      end
    end
    if @upictures=='true'
      @service.picture=@@pictures
      respond_to do |format|
        format.js { render 'images' }
        format.json { render :edit, status: :ok, location: @service }
      end
    else
      @service.assign_attributes(service_params);
      @service.picture=@@pictures
      respond_to do |format|
        if @service.save
          if @upictures=='false'
            format.html { redirect_to @service, notice: t('.service_was_successfully_updated') }
            format.json { render :show, status: :ok, location: @service }  
          end
        else
          format.js { render 'form' }
          format.json { render json: @service.errors, status: :unprocessable_entity }
          flash[:errors] = @service.errors.messages.as_json
          puts "***************"
          puts flash[:errors]
          puts "***************"
        end
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
    if params[:id]
      @service = Service.find(params[:id])
    else
      @service=@@servicec
    end

    @service.picture=@@pictures
    delete_picture(@@pictures,@service,params[:index].to_i)
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:title, :description, :user_id, {:picture_attributes => [:files=>[]]})
    end

    def require_admin
      admin_require(services_url)
    end
end
