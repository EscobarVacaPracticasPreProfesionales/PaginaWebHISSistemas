class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :destroy_picture]
  before_action :require_admin, only: [:edit, :update, :destroy, :destroy_picture]
  before_action :is_admin, only: [:index]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @articles= Article.where.not(id: @article.id).order("RANDOM()").limit(5)

  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @upictures=params[:update_pictures].to_s
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        if @upictures=='false'
          format.html { redirect_to @article, notice: t('.article_was_successfully_created') }
          format.json { render :show, status: :created, location: @article }
        else
          format.html { redirect_to edit_article_path(@article)}
          format.json { render :edit, status: :ok, location: @article }
        end
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    @upictures=params[:update_pictures].to_s
    updated_params=add_pictures(@article,article_params)

    respond_to do |format|
      if @article.update(updated_params)
        if @upictures=='false'
          format.html { redirect_to @article, notice: t('.article_was_successfully_updated') }
          format.json { render :show, status: :ok, location: @article }
        else
          format.js
          format.json { render :edit, status: :ok, location: @article }
        end
        
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: t('.article_was_successfully_destroyed') }
      format.json { head :no_content }
    end
  end

  def destroy_picture
    delete_picture(@article,params[:index].to_i)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :description, :content, {pictures: []}, :figcaption, :fecha, :user_id)
    end

    def require_admin
      admin_require(services_url)
    end
end
