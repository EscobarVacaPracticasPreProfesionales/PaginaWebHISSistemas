class Contact < ApplicationRecord
	has_one :user
	validates_presence_of :name
	validates_presence_of :lastname
	validates_presence_of :phone1

	before_create :default_company
	before_create :default_phone2


	def default_company
		self.company="N/A" if company.blank?
	end
	def default_phone2
		self.phone2="N/A" if phone2.blank?
	end
end
