class Reference < ApplicationRecord
	belongs_to :user
	belongs_to :picture , dependent: :destroy

	after_initialize do
		build_picture if new_record? && picture.blank?
	end
	
	accepts_nested_attributes_for :user
	accepts_nested_attributes_for :picture
	validates_associated :picture

	validates_presence_of :title, 		on: [:create, :update]
	validates_presence_of :content, 	on: [:create, :update]
	validates_presence_of :year, 		on: [:create, :update]

end
