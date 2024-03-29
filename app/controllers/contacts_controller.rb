# frozen_string_literal: true

class ContactsController < ApplicationController
  before_action :set_contact, only: %i[show edit update destroy]

  # GET /contacts or /contacts.json
  def index
    @contacts = current_user.contacts.order(created_at: :desc)
  end

  # GET /contacts/1 or /contacts/1.json
  def show; end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update(@contact, partial: "contacts/form", locals: { contact: @contact })
        ]
      end
    end
  end

  # POST /contacts or /contacts.json
  def create
    @contact = current_user.contacts.build(contact_params)

    respond_to do |format|
      if @contact.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update("new-form", partial: "contacts/form", locals: { contact: Contact.new }),
            turbo_stream.prepend("contacts", partial: "contacts/contact", locals: { contact: @contact }),
            turbo_stream.update("number_of_contacts", html: current_user.contacts.size),
            turbo_stream.update("notice", html: Constants::CREATE_CONTACT_SUCCESS_MESSAGE)
          ]
        end
        format.html { redirect_to contact_url(@contact), notice: Constants::CREATE_CONTACT_SUCCESS_MESSAGE }
        format.json { render :show, status: :created, location: @contact }
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update("create-contact-form", partial: "contacts/form", locals: { contact: @contact }),
            turbo_stream.update("alert", html: @contact.errors.full_messages)
          ]
        end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1 or /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(@contact, partial: "contacts/contact", locals: { contact: @contact }),
            turbo_stream.update("notice", html: Constants::UPDATE_CONTACT_SUCCESS_MESSAGE)
          ]
        end
        format.html { redirect_to contact_url(@contact), notice: Constants::UPDATE_CONTACT_SUCCESS_MESSAGE }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(@contact, partial: "contacts/contact", locals: { contact: @contact }),
            turbo_stream.update("alert", html: @contact.errors.full_messages)
          ]
        end
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1 or /contacts/1.json
  def destroy
    @contact.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(@contact),
          turbo_stream.update("number_of_contacts", html: current_user.contacts.size),
          turbo_stream.update("notice", html: Constants::DESTROY_CONTACT_SUCCESS_MESSAGE)
        ]
      end
      format.html { redirect_to contacts_url, notice: Constants::DESTROY_CONTACT_SUCCESS_MESSAGE }
      format.json { head :no_content }
    end
  end

  def search
    @results = current_user.contacts.where("name ILIKE ?", "%#{params[:search_params]}%").order(created_at: :desc)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("contacts", partial: "contacts/search_results", locals: { results: @results }),
          turbo_stream.update("number_of_contacts", html: @results.size)
        ]
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = current_user.contacts.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def contact_params
    params.require(:contact).permit(:name, :email, :image)
  end
end
