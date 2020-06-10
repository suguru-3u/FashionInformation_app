class Users::FavoritesController < ApplicationController

  def create
    @post = current_user.favorites.new(post_id: params[:post_id])
    @post.save ? redirect_back(fallback_location: root_path) : redirect_back(fallback_location: root_path)
  end

  def destroy
    if @favorite = Favorite.find_by(post_id: params[:post_id], user_id: current_user.id)
      @favorite.destroy
    end
    redirect_back(fallback_location: root_path)
  end

end
