class ContactsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  # GET /contacts
  # GET /contacts.json
  def index
    
    @contacts = @user.contacts
    if params[:order] && ["asc", "desc"].include?(params[:sort_mode])
      order = params[:order].split(",").map {|o| "#{o} #{params[:sort_mode]}" }.join(", ")
      @contacts = @contacts.order(order)
    end
    if params[:search].present? && params[:utf8] == "✓"
      logger.info"#{params[:search]}"
      @contacts = @contacts.search(params[:search])

    end
    @contacts = @contacts.paginate(:per_page => 10, :page => params[:page])
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
    @contact = Contact.new(contact_params)

    @contact.user = @user

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
    @contact.user = @user

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
      params.require(:contact).permit(:first_name, :middle_name, :last_name, :address, :city, :state, :country, :phone_number, :fax_number, :email, :gender, :age, :contactable_id, :contactable_type, :case_id, :user_id, :contact_user_id)
    end
end
