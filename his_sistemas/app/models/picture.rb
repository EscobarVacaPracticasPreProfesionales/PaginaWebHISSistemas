class Picture < ApplicationRecord
	has_one :service
  	mount_uploaders :files, PictureUploader
  	serialize :files, JSON
  	
	validates_presence_of :files, 	on: :create
end
