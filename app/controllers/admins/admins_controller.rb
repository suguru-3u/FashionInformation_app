class Admins::AdminsController < ApplicationController

  def show
    @users = User.count
    @today_registrations = User.where("created_at >= ?", Time.zone.now.beginning_of_day).count
    @posts = Post.where(solution: false).count
    @contacts = Contact.where(solution: false).count
  end

end
