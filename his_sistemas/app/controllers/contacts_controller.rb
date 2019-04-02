class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:edit, :update, :destroy]
  before_action :set_contacts_customers, only: [:index, :check_contact]
  before_action :is_admin, only: [:index]
  

  # GET /contacts
  # GET /contacts.json
  def index
    @user_types=UserType.all
    puts "****************************"
    puts @user_types
    puts "****************************"
    new
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @param=params[:contact][:doc]
    if @param.nil?
      ContactMailer.with(contact: email_params).contact_msg.deliver_later

    else
      @doc=Picture.new(:files => [@param])
      @doc.save
      ContactMailer.with(contact: email_params, doc: @doc.id).contact_msg.deliver_later
    end
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.js {render 'create'}
        format.json { render :index, status: :ok}
      else
        format.html { render :index }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def check_contact
    
    if params[:contactado]
      Contact.where(id: params[:contacto_id]).update_all(wascontacted: true)
    elsif params[:noContactado]
      Contact.where(id: params[:contacto_id]).update_all(wascontacted: false)
    else
      Contact.where(id: params[:contacto_id]).destroy_all
    end

    respond_to do |format|
      format.js
      format.json { render :index, status: :ok, location: 'index' }
    end
  end


  def change_user_type
    puts "******************************"
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def set_contacts_customers
      @users = Contact.where(id: User.where(user_type_id: 2).select('contact_id'))
      @contacts = Contact.where.not(id: User.joins(:contact).select('contact_id'))
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:name,:lastname, :company, :phone1, :phone2, :emailcontact)
    end

    def email_params
      params.require(:contact).permit(:name,:lastname, :company, :phone1, :phone2, :emailcontact, :asunto, :mensaje)
    end

    def require_admin
      admin_require(services_url)
    end


end
