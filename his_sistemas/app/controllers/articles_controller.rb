class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:edit,:edit, :new, :update, :destroy, :destroy_picture]
  before_action :is_admin, only: [:index, :show]

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
    @article = Article.new
    @@picid=-1;
  end

  # GET /articles/1/edit
  def edit
    flash[:errors] = nil
  end

  # POST /articles
  # POST /articles.json
  def create
    if params[:update_pictures].to_s == "true"
      if @@picid>=0
        @picture=Picture.find(@@picid)
        updated_params=add_pictures(@picture,article_params['picture_attributes'])
        @picture.update(updated_params)
      else
        @picture=Picture.new(article_params['picture_attributes'])
        @picture.save
        @@picid=@picture.id
      end
      respond_to do |format|
        format.js { render 'images' }
        format.json { render :new, status: :ok, location: @picture }
      end
    else
      @article=Article.new(article_params)
      if @@picid>=0
        @article.picture = Picture.find(@@picid)
      end
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
    return
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    @upictures=params[:update_pictures].to_s
    if @upictures=='true'
      updated_params=add_pictures(@picture,article_params['picture_attributes'])
      @picture.update(updated_params)
      respond_to do |format|
        format.js { render 'images' }
        format.json { render :edit, status: :ok, location: @picture }
      end
    else
      respond_to do |format|
        if @article.update(article_params)
          format.html { redirect_to @article, notice: t('.article_was_successfully_updated') }
          format.json { render :show, status: :ok, location: @article }  
        else
          format.js { render 'form' }
          format.json { render json: @article.errors, status: :unprocessable_entity }
          flash[:errors] = @article.errors.messages.as_json
        end
      end
    end
    return
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
    @picture = Picture.find(params[:id])
    delete_picture(@picture,params[:index].to_i)
    return
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
      @picture = @article.picture
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :description, :content, :figcaption, :fecha, :user_id,{:picture_attributes => [:files=>[]]})
    end

    def require_admin
      admin_require(articles_url)
    end
end
