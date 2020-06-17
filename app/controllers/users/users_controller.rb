class Users::UsersController < ApplicationController
  before_action :user_information, only:[:show,:edit,:update]
  before_action :user_post_information, only:[:show,:update]

  def show
  end

  def update
    @user.update(user_params) ? redirect_to(users_users_path) : render(:show)
  end

  private
  def user_params
		params.require(:user).permit(:name,:email,:sex_status,:age)
  end

  def user_information
    @user = current_user
  end

  def user_post_information
    @posts = current_user.posts
    @current_user_favorites = current_user.favorites_post
    @current_user_comments = current_user.comments_post
  end

end
