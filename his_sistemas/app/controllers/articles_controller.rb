class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:edit, :edit, :new, :update, :destroy, :destroy_picture]
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
    flash[:errors] = nil
    @@articlec = Article.new
    @@pictures= Picture.new
    @article=@@articlec
    @@articlec.picture=@@pictures
  end

  # GET /articles/1/edit
  def edit
    flash[:errors] = nil
    @@pictures= Picture.new
    @@pictures.files=@article.picture.files
  end

  # POST /articles
  # POST /articles.json
  def create
    if article_params['picture_attributes']
      if article_params['picture_attributes']['files']
        @@pictures.files+=article_params['picture_attributes']['files']
      end
    end
    if params[:update_pictures].to_s == "true"
      @@articlec.picture=@@pictures
      @article=@@articlec
      respond_to do |format|
        format.js { render 'images' }
        format.json { render :new, status: :ok, location: @article }
      end
    else
    @article = article.new(article_params)
      @article.picture=@@pictures
      respond_to do |format|        
        if @article.save
          format.html { redirect_to @article, notice: t('.article_was_successfully_created') }
          format.json { render :show, status: :created, location: @article }
        else
          flash[:errors] = @article.errors.messages.as_json
          format.js { render 'form' }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    @upictures=params[:update_pictures].to_s
    if article_params['picture_attributes']
      if article_params['picture_attributes']['files']
        @@pictures.files+=article_params['picture_attributes']['files']
      end
    end
    if @upictures=='true'
      @article.picture=@@pictures
      respond_to do |format|
        format.js { render 'images' }
        format.json { render :edit, status: :ok, location: @article }
      end
    else
      @article.assign_attributes(article_params);
      @article.picture=@@pictures
      respond_to do |format|
        if @article.save
          if @upictures=='false'
            format.html { redirect_to @article, notice: t('.article_was_successfully_updated') }
            format.json { render :show, status: :ok, location: @article }  
          end
        else
          format.js { render 'form' }
          format.json { render json: @article.errors, status: :unprocessable_entity }
          flash[:errors] = @article.errors.messages.as_json
          puts "***************"
          puts flash[:errors]
          puts "***************"
        end
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
    if params[:id]
      @article = Article.find(params[:id])
    else
      @article=@@articlec
    end

    @article.picture=@@pictures
    delete_picture(@@pictures,@article,params[:index].to_i)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :description, :content, :figcaption, :fecha, :user_id,{:picture_attributes => [:files=>[]]})
    end

    def require_admin
      admin_require(articles_url)
    end
end
