class Admins::ContactsController < ApplicationController
  before_action :post_information, only:[:show,:update,:destroy]

  def index
    @contacts_solution = Contact.where(solution: false).recent.page(params[:page]).per(20).search(params[:title])
    @contacts = Contact.recent.page(params[:page]).per(20).search(params[:title])
  end

  def show
  end

  def update
    @contact.update(contact_params) ? redirect_to(admins_contacts_path) : render(:index)
  end

  def destroy
    @contact.destroy ? redirect_to(admins_contacts_path) : render(:index)
  end

  private
  def contact_params
    params.require(:contact).permit(:title,:contact_body,:solution)
  end

  def post_information
    @contact = Contact.find(params[:id])
  end
end
