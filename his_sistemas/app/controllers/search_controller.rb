class SearchController < ApplicationController
	def index
	end

	def search_articles
		if search_params[:word].blank?
			@articles=Article.all
		else
    		@articles = Article.where("title LIKE '%#{params[:word]}%' OR description LIKE '%#{params[:word]}%' OR content LIKE '%#{params[:word]}%'"  )
		end
		render 'index'
	end
	
	private
		def search_params
			params.permit(:word)
		end
end