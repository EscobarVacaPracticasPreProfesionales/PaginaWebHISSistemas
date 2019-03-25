class Service < ApplicationRecord
  	belongs_to :user

	accepts_nested_attributes_for :user

  	mount_uploaders :pictures, PictureUploader
  	serialize :pictures, JSON
  	
	validates_presence_of :pictures
	validates_presence_of :title
	validates_presence_of :description
end
