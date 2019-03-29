class SearchController < ApplicationController
	def index
	end

	def search_articles
		if params[:word].blank?
			@articles=Article.all
		else
    		@articles = Article.where('title LIKE ?', params[:word])
		end
		puts "*************"
		puts @articles.to_json
		puts "*************"
		respond_to do |format|
			format.html { redirect_to "/search"}
          	format.json { render :show, status: :ok, location: '/search' }
		end
	end
end