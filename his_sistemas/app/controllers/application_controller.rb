class ApplicationController < ActionController::Base
	before_action :store_user_location!, if: :storable_location?
	
	def search_article
	end

	private
	# Its important that the location is NOT stored if:
	# - The request method is not GET (non idempotent)
	# - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an 
	#    infinite redirect loop.
	# - The request is an Ajax request as this can lead to very unexpected behaviour.
	def storable_location?
	  request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
	end


	def store_user_location!
	  # :user is the scope we are authenticating
	  store_location_for(:user, request.fullpath)
	end

	def delete_picture(pictures,model,index)
		remain_images=pictures.files
		deleted_images=remain_images.delete_at(index)
		pictures.files=remain_images
		model.picture=pictures
	    respond_to do |format|
	      	format.js {render 'images'}
	        format.json { render :edit, status: :ok, location: model }
	    end
	end
	
	def is_logged(tipo)
    	if current_user
  			return current_user.user_type.tipo == tipo
      	end
      	return false
  	end

  	def is_admin
  		@user_admin=is_logged("Administrador")
  	end

  	def admin_require(resource_path)
  		if !is_admin
  			redirect_to resource_path
  		end
  	end
end
