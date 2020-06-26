class Users::UsersController < ApplicationController
  before_action :my_page_infomration, only:[:show,:update]

  def show
    @solution_posts = Post.where(solution: false).recent.page(params[:page]).per(9)
  end

  def update
    if current_user.update(user_params)
      NotificationMailer.user_update(current_user).deliver_now
      flash[:primary] = 'ユーザー情報の変更が完了しました'
      redirect_to(users_users_path)
    else
      flash.now[:alert] = 'ユーザー情報の変更が失敗しました'
      render(:show)
    end
  end

  private
  def user_params
		params.require(:user).permit(:name,:email)
  end

  def my_page_infomration
    @user = current_user
    @posts = current_user.posts.recent.page(params[:page]).per(9)
    @current_user_favorites = current_user.favorites_post.recent.page(params[:page]).per(9)
    @current_user_comments = current_user.comments_post.recent.page(params[:page]).per(9)
  end

end
