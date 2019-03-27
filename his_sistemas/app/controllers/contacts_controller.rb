class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:edit, :update, :destroy]
  before_action :is_admin, only: [:index]
  

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts=Contact.where.not(id: User.where(user_type_id: 1).select('contact_id'))
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
    ContactMailer.with(contact: params[:contact]).contact_msg.deliver_now
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
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
    @contacts=Contact.where.not(id: User.where(user_type_id: 1).select('contact_id'))
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:name,:lastname, :company, :phone1, :phone2, :emailcontact)
    end

    def require_admin
      admin_require(services_url)
    end


end
