class Users::ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = current_user.contacts.new(contcts_params)
    @contact.save ? redirect_to(users_posts_path) : render(:new)
  end

  private
  def contcts_params
    params.require(:contact).permit(:title,:contact_body)
  end

end
