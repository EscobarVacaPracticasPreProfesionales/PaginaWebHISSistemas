class User < ApplicationRecord
  	after_create :set_admin

	belongs_to :user_type
	belongs_to :contact, autosave: true
	has_many :services
	has_many :references
	has_many :articles

	accepts_nested_attributes_for :contact, update_only: true
	accepts_nested_attributes_for :user_type
	validates_associated :contact
	
	attribute :user_type_id, :integer, default: 2
	after_initialize do
		build_contact if new_record? && contact.blank?
	end

  	private
    	def set_admin
  			@user=User.first
      		if @user.user_type.tipo != "SuperAdministrador"
    			@user.update(user_type_id: 3)
      		end
    	end

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable, :rememberable, :validatable, :confirmable, :recoverable, :async
end
