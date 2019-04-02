class ReferencesController < ApplicationController
  before_action :set_reference, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:edit, :show, :new, :update, :destroy, :destroy_picture]
  before_action :is_admin, only: [:index]
  # GET /references
  # GET /references.json
  def index
    @references = Reference.all
  end

  # GET /references/1
  # GET /references/1.json
  def show
  end

  # GET /references/new
  def new
    flash[:errors] = nil
    @reference=Reference.new
    @@picid=-1;
  end

  # GET /references/1/edit
  def edit
    flash[:errors] = nil
  end

  # POST /references
  # POST /references.json
  def create
    if params[:update_pictures].to_s == "true"
      if @@picid>=0
        @picture=Picture.find(@@picid)
        updated_params=add_pictures(@picture,reference_params['picture_attributes'])
        @picture.update(updated_params)
      else
        @picture=Picture.new(reference_params['picture_attributes'])
        @picture.save
        @@picid=@picture.id
      end
      respond_to do |format|
        format.js { render 'images' }
        format.json { render :new, status: :ok, location: @picture }
      end
    else
      @reference=Reference.new(reference_params)
      if @@picid>=0
        @reference.picture = Picture.find(@@picid)
      end
      respond_to do |format|        
        if @reference.save
          format.html { redirect_to @reference, notice: t('.reference_was_successfully_created') }
          format.json { render :show, status: :created, location: @reference }
        else
          flash[:errors] = @reference.errors.messages.as_json
          format.js { render 'form' }
          format.json { render json: @reference.errors, status: :unprocessable_entity }
        end
      end
    end
    return
  end

  # PATCH/PUT /references/1
  # PATCH/PUT /references/1.json
  def update
    @upictures=params[:update_pictures].to_s
    if @upictures=='true'
      updated_params=add_pictures(@picture,reference_params['picture_attributes'])
      @picture.update(updated_params)
      respond_to do |format|
        format.js { render 'images' }
        format.json { render :edit, status: :ok, location: @picture }
      end
    else
      respond_to do |format|
        if @reference.update(reference_params)
          format.html { redirect_to @reference, notice: t('.reference_was_successfully_updated') }
          format.json { render :show, status: :ok, location: @reference }  
        else
          format.js { render 'form' }
          format.json { render json: @reference.errors, status: :unprocessable_entity }
          flash[:errors] = @reference.errors.messages.as_json
        end
      end
    end
    return
  end

  # DELETE /references/1
  # DELETE /references/1.json
  def destroy
    @reference.destroy
    respond_to do |format|
      format.html { redirect_to references_url, notice: 'Reference was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_picture
    @picture = Picture.find(params[:id])
    delete_picture(@picture,params[:index].to_i)
    return
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reference
      @reference = Reference.find(params[:id])
      @picture = @reference.picture
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reference_params
      params.require(:reference).permit(:title, :content, :year, :user_id, {:picture_attributes => [:id,:linked,:files=>[]]})
    end

    def require_admin
      admin_require(references_url)
    end
end
