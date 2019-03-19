class ContactMailer < ApplicationMailer
	default from: 'response.hissistemas@gmail.com'
	

	def contact_msg
		@asunto=params[:asunto]
		@mensaje=params[:mensaje]
		mail(to:"hissistemasgye@gmail.com",subject: "New entry")

	end

end
