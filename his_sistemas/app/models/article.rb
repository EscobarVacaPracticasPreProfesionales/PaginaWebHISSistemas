class Article < ApplicationRecord
	belongs_to :user
  	belongs_to :picture, dependent: :destroy
	
	after_initialize do
		build_picture if new_record? && picture.blank?
	end
	
	accepts_nested_attributes_for :user
	accepts_nested_attributes_for :picture, update_only: true
	validates_associated :picture

	validates_presence_of :title, 		on: [:create, :update]
	validates_presence_of :description, on: [:create, :update]  
	validates_presence_of :content, 	on: [:create, :update]  
	validates_presence_of :figcaption, 	on: [:create, :update]  
	validates_presence_of :fecha, 		on: [:create, :update]  
end
