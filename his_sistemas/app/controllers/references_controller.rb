class ReferencesController < ApplicationController
  before_action :set_reference, only: [:show, :edit, :update, :destroy, :destroy_picture]
  before_action :require_admin, only: [:edit, :update, :destroy, :destroy_picture]
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
    @reference = Reference.new
  end

  # GET /references/1/edit
  def edit
     @new_record=params[:is_new]
  end

  # POST /references
  # POST /references.json
  def create
    @upictures=params[:update_pictures].to_s
    @reference = Reference.new(reference_params)

    respond_to do |format|
      if @reference.save
        if @upictures=='false'
          format.html { redirect_to @reference, notice: t('.reference_was_successfully_created') }
          format.json { render :show, status: :created, location: @reference }
        else
          format.html { redirect_to edit_reference_path(@reference,is_new: true)}
          format.json { render :edit, status: :ok, location: @reference }
        end
      else
        format.html { render :new }
        format.json { render json: @reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /references/1
  # PATCH/PUT /references/1.json
  def update
    @upictures=params[:update_pictures].to_s
    updated_params=add_pictures(@reference,reference_params)

    respond_to do |format|
      if @reference.update(updated_params)
        if @upictures=='false'
          format.html { redirect_to @reference, notice: t('.reference_was_successfully_updated') }
          format.json { render :show, status: :ok, location: @reference }
        else
          format.js
          format.json { render :edit, status: :ok, location: @reference }
        end
      else
        format.html { render :edit }
        format.json { render json: @reference.errors, status: :unprocessable_entity }
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
    delete_picture(@reference,params[:index].to_i)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reference
      @reference = Reference.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reference_params
      params.require(:reference).permit(:title, :content, :year, :user_id, {pictures: []})
    end

    def require_admin
      admin_require(services_url)
    end
end
