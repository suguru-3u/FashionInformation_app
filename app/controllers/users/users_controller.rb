class Users::UsersController < ApplicationController
  before_action :user_information, only:[:show,:edit,:update]
  
  def show
  end

  def edit
  end

  def update
    @user.update(user_params) ? redirect_to(edit_users_users_path) : render(:edit)
  end

  private
  def user_params
		params.require(:user).permit(:name,:email,:sex_status,:age)
  end

  def user_information
    @user = current_user
  end

end
