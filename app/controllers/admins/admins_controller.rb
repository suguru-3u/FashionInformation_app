class Admins::AdminsController < ApplicationController
  def show
    @users = User.count
    @today_registrations = User.where("created_at >= ?", Time.zone.now.beginning_of_day).count
    @posts_solution = Post.where(solution: false).count
    @posts = Post.all
    @contacts_solution = Contact.where(solution: false).count
    @contacts = Contact.all
    @notice = Notice.all
  end
end
