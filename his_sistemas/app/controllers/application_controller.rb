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

	def add_pictures(model,model_params)
		pictures=model.pictures
		if model_params[:pictures]
			pictures+=model_params[:pictures]
		end
		pics={pictures: pictures}
		model_params.merge(pics)
	end

	def delete_picture(model, index)
		remain_images=model.pictures
		if index==0 && model.pictures.size==1
			model.remove_pictures!
		else
			deleted_images=remain_images.delete_at(index)
			deleted_images.try(:remove!)
		end
		puts '*******************'
		puts '/'+model.class.to_s.underscore.pluralize+'/'+model.id.to_s+'/edit'
		puts '*******************'
		
	    respond_to do |format|
	      if model.update(:pictures=>remain_images)
	        format.html { redirect_to '/'+model.class.to_s.underscore.pluralize+'/'+model.id.to_s+'/edit', notice: t('.picture_was_successfully_deleted.') }
	        format.json { render :index, status: :ok, location: model }
	      else
	        format.html { render :edit }
	        format.json { render json: model.errors, status: :unprocessable_entity }
	      end
	    end
	end
end
