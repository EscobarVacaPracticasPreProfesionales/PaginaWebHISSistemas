class Service < ApplicationRecord
  	belongs_to :user
  	belongs_to :picture

	accepts_nested_attributes_for :user
	accepts_nested_attributes_for :picture
	validates_associated :picture

	validates_presence_of :title, 		on: [:create, :update]
	validates_presence_of :description, on: [:create, :update]
end
