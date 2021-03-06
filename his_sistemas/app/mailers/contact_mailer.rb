class ContactMailer < ApplicationMailer
	default from: ENV["GMAIL_USERNAME"]
	

	def contact_msg
		@contact=params[:contact]
		@name=@contact[:name]
		@lastname=@contact[:lastname]
		@company=@contact[:company]
		@phone1=@contact[:phone1]
		@phone2=@contact[:phone2]
		@email=@contact[:emailcontact]
		@asunto=@contact[:asunto]
		@mensaje=@contact[:mensaje]
		@doc=params[:doc]
		@url=params[:url]
		if @doc!= nil
			attach=Picture.find(@doc)
			attachments[@url] = attach.retrieve_from_store!(@url)
		end
		mail(to:"hissistemasgye@gmail.com",subject: "HIS #{@asunto}")
	end

end
