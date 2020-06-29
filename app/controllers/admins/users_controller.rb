class Admins::UsersController < ApplicationController
  before_action :user_information, only:[:edit,:update,:destroy]

  def index
    @users = User.recent.page(params[:page]).per(20).search(params[:name])
  end

  def edit
  end

  def update
    @user.update(user_params) ? redirect_to(admins_users_path) : render(:edit)
  end

  def destroy
    @user.destroy ? redirect_to(admins_users_path) : render(:index)
  end

  private
  def user_params
    params.require(:user).permit(:name,:email)
  end

  def user_information
    @user = User.find(params[:id])
  end

end
