class SearchController < ApplicationController
	def index
	end

	def search_articles
		respond_to do |format|
			format.html { redirect_to "/search"}
		end
	end
end