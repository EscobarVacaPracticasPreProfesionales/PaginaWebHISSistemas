class Contact < ApplicationRecord
	has_one :user
	validates_presence_of :name
	validates_presence_of :lastname
	validates_presence_of :company
	validates_presence_of :phone1
end
