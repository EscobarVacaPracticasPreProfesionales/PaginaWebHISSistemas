class Service < ApplicationRecord
  	belongs_to :user

	accepts_nested_attributes_for :user

  	mount_uploaders :pictures, PictureUploader
  	serialize :pictures, JSON
  	
	validates_presence_of :pictures, 	on: :create
	validates_presence_of :title, 		on: :update
	validates_presence_of :description, on: :update
end
