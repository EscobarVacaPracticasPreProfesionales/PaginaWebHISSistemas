class ReferencesController < ApplicationController
  before_action :set_reference, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:edit, :edit, :new, :update, :destroy, :destroy_picture]
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
    @@referencec = Reference.new
    @@pictures= Picture.new
    @reference=@@referencec
    @@referencec.picture=@@pictures
  end

  # GET /references/1/edit
  def edit
    flash[:errors] = nil
    @@pictures= Picture.new
    @@pictures.files=@reference.picture.files
  end

  # POST /references
  # POST /references.json
  def create
    if reference_params['picture_attributes']
      if reference_params['picture_attributes']['files']
        @@pictures.files+=reference_params['picture_attributes']['files']
      end
    end
    if params[:update_pictures].to_s == "true"
      @@referencec.picture=@@pictures
      @reference=@@referencec
      respond_to do |format|
        format.js { render 'images' }
        format.json { render :new, status: :ok, location: @reference }
      end
    else
      @reference = Reference.new(reference_params)
      @reference.picture=@@pictures
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
  end

  # PATCH/PUT /references/1
  # PATCH/PUT /references/1.json
  def update
    @upictures=params[:update_pictures].to_s
    if reference_params['picture_attributes']
      if reference_params['picture_attributes']['files']
        @@pictures.files+=reference_params['picture_attributes']['files']
      end
    end
    if @upictures=='true'
      @reference.picture=@@pictures
      respond_to do |format|
        format.js { render 'images' }
        format.json { render :edit, status: :ok, location: @reference }
      end
    else
      @reference.assign_attributes(reference_params);
      @reference.picture=@@pictures
      respond_to do |format|
        if @reference.save
          if @upictures=='false'
            format.html { redirect_to @reference, notice: t('.reference_was_successfully_updated') }
            format.json { render :show, status: :ok, location: @reference }  
          end
        else
          format.js { render 'form' }
          format.json { render json: @reference.errors, status: :unprocessable_entity }
          flash[:errors] = @reference.errors.messages.as_json
          puts "***************"
          puts flash[:errors]
          puts "***************"
        end
      end
    end
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
    if params[:id]
      @reference = Reference.find(params[:id])
    else
      @reference=@@referencec
    end

    @reference.picture=@@pictures
    delete_picture(@@pictures,@reference,params[:index].to_i)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reference
      @reference = Reference.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reference_params
      params.require(:reference).permit(:title, :content, :year, :user_id, {:picture_attributes => [:files=>[]]})
    end

    def require_admin
      admin_require(references_url)
    end
end
