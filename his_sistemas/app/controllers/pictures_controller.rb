class PicturesController < ApplicationController
	before_action :set_gallery

  def create
    add_more_images(images_params[:pictures]))
    flash[:error] = "Failed uploading images" unless @gallery.save
    redirect_to :back
  end

  private

  def set_gallery
    @gallery = Service.find(params[:service_id])
  end

  def add_more_images(new_images)
    images = @gallery.pictures # copy the old images 
    images += new_images # concat old images with new ones
    @gallery.images = images # assign back
  end

  def images_params
    params.require(:service).permit({pictures: []}) # allow nested params as array
  end
end
