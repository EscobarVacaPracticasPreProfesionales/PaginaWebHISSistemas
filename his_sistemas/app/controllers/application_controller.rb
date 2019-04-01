class ApplicationController < ActionController::Base
	before_action :store_user_location!, if: :storable_location?
	
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

	def add_pictures(model,pic_params)
		pictures=model.files
		if pic_params[:files]
			pictures+=pic_params[:files]
		end
		pics={files: pictures}
		pic_params.merge(pics)
	end

	def delete_picture(model, index)
		remain_images=model.files
		if index==0 && model.files.size==1
	    	respond_to do |format|
				format.js
		        format.json { render json: model.errors, status: :unprocessable_entity }
				flash[:errors] = {'picture.files': {"caca": "pepe"}}
			end
			return
		else
			deleted_images=remain_images.delete_at(index)
			#deleted_images.try(:remove!)
		end
	    respond_to do |format|
	      if model.update(:files=>remain_images)
	      	format.js { render 'images'}
  			format.json { head :no_content }
	      else
	        format.html { render :edit }
	        format.json { render json: model.errors, status: :unprocessable_entity }
          	flash[:errors] = @service.errors.messages.as_json
	      end
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
