class Admins::NoticesController < ApplicationController
  before_action :note_information, only: [:edit, :update, :destroy]

  def index
    @notices = Notice.recent.page(params[:page]).per(20).search(params[:announce_title])
    @notice = Notice.new
  end

  def edit; end

  def create
    @notices = Notice.all
    @notice = Notice.new(notices_params)
    @notice.save ? redirect_to(admins_notices_path) : render(:index)
  end

  def destroy
    @notice.destroy ? redirect_to(admins_notices_path) : render(:index)
  end

  def update
    @notice.update(notices_params) ? redirect_to(admins_notices_path) : render(:edit)
  end

  private

  def notices_params
    params.require(:notice).permit(:announce_title, :announce_body)
  end

  def note_information
    @notice = Notice.find(params[:id])
  end
end
