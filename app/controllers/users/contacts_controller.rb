class Users::ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = current_user.contacts.new(contcts_params)
    if @contact.save
      NotificationMailer.user_contact.deliver_now
      redirect_to(users_homes_my_page_path)
    else
      render(:new)
    end
  end

  private
  def contcts_params
    params.require(:contact).permit(:title,:contact_body)
  end

end
