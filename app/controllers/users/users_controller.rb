class Users::UsersController < ApplicationController
  before_action :user_information, only:[:show,:update]

  def show
    @posts = current_user.posts.order(created_at: "DESC").page(params[:page]).per(9)
    @current_user_favorites = current_user.favorites_post.order(created_at: "DESC").page(params[:page]).per(9)
    @current_user_comments = current_user.comments_post.order(created_at: "DESC").page(params[:page]).per(9)
    @solution_posts = Post.where(solution: true).order(created_at: "DESC").page(params[:page]).per(9)
  end

  def update
    if @user.update(user_params)
      NotificationMailer.user_update(current_user).deliver_now
      redirect_to(users_users_path)
    else
      @posts = current_user.posts
      @current_user_favorites = current_user.favorites_post
      @current_user_comments = current_user.comments_post
      render(:show)
    end
  end

  private
  def user_params
		params.require(:user).permit(:name,:email,:sex_status,:age)
  end

  def user_information
    @user = current_user
  end

end
