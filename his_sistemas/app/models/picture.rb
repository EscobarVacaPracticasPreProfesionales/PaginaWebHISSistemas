class Picture < ApplicationRecord
	has_one :service
	has_one :reference
	has_one :article
  	mount_uploaders :files, PictureUploader
  	serialize :files, JSON
  	
	validates_presence_of :files, 	on: [:create, :update]
end
