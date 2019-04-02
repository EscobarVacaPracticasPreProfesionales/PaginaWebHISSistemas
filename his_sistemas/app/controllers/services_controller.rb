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
    @service=Service.new
    @@picid=-1;
  end

  # GET /services/1/edit
  def edit
    flash[:errors] = nil
  end

  # POST /services
  # POST /services.json
  def create  
    if params[:update_pictures].to_s == "true"
      if @@picid>=0
        @picture=Picture.find(@@picid)
        updated_params=add_pictures(@picture,service_params['picture_attributes'])
        @picture.update(updated_params)
      else
        @picture=Picture.new(service_params['picture_attributes'])
        @picture.save
        @@picid=@picture.id
      end
      respond_to do |format|
        format.js { render 'images' }
        format.json { render :new, status: :ok, location: @picture }
      end
    else
      @service=Service.new(service_params)
      if @@picid>=0
        @service.picture = Picture.find(@@picid)
      end
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
    return
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    @upictures=params[:update_pictures].to_s
    if @upictures=='true'
      updated_params=add_pictures(@picture,service_params['picture_attributes'])
      @picture.update(updated_params)
      respond_to do |format|
        format.js { render 'images' }
        format.json { render :edit, status: :ok, location: @picture }
      end
    else
      respond_to do |format|
        if @service.update(service_params)
          format.html { redirect_to @service, notice: t('.service_was_successfully_updated') }
          format.json { render :show, status: :ok, location: @service }  
        else
          format.js { render 'form' }
          format.json { render json: @service.errors, status: :unprocessable_entity }
          flash[:errors] = @service.errors.messages.as_json
        end
      end
    end
    return
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to services_url, notice: t('.service_was_successfully_destroyed') }
      format.json { head :no_content }
    end
    return
  end

  def destroy_picture
    @picture = Picture.find(params[:id])
    delete_picture(@picture,params[:index].to_i)
    return
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
      @picture = @service.picture
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:title, :description, :user_id, picture_attributes: [:id,:linked,:files=>[]])
    end

    def require_admin
      admin_require(services_url)
    end
end
