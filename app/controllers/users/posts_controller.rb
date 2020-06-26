class Users::PostsController < ApplicationController
    before_action :post_get_id, only:[:show,:edit,:update,:destroy]
    before_action :user_recent_post, only:[:index,:search,:create]
    before_action :post_new, only:[:index,:search]
    before_action :post_solution_search_false, only:[:index,:create]

  def index
  end

  def create
    @post = current_user.posts.new(posts_params)
    if @post.save
      flash[:primary] = '投稿が完了しました'
      respond_to do |format|
        format.html { redirect_to(users_posts_path) }
        format.json
      end
    else
      flash.now[:alert] = '投稿が失敗しました'
      render(:index)
    end
  end


  def show
    @comments = @post.comments.page(params[:page]).per(9)
    @comment = Comment.new
  end

  def update
    if @post.solution = params[:solution]
      @post.update ? redirect_to(users_posts_path) : render(:show)
    end
    if @post.update(posts_params)
      flash[:primary] = '投稿内容を変更しました'
      redirect_to users_posts_path
    else
      flash.now[:alert] = '投稿内容の編集に失敗しました'
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:primary] = '投稿内容を削除しました'
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = '投稿内容の削除に失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  def search
   if params[:name]
     if params[:name].empty?
       @posts = Post.none.page(params[:page]).per(9)
     else
       @posts = Post.where('title LIKE(?)', "%#{params[:name]}%").recent.page(params[:page]).per(9)
     end
   else
      @posts = Post.recent.page(params[:page]).per(9)
   end

   respond_to do |format|
    format.html
    format.json
   end

  end

  private
  def posts_params
    params.require(:post).permit(:title,:post_body,:post_image,:solution)
  end

  def post_get_id
    @post = Post.find(params[:id])
  end

  def user_recent_post
    @users = User.recent_post
  end

  def post_new
    @post = Post.new
  end

  def post_solution_search_false
    @posts = Post.where(solution: false).recent.page(params[:page]).per(9)
  end

end
