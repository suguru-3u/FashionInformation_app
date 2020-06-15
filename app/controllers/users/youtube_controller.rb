class Users::YoutubeController < ApplicationController
  GOOGLE_API_KEY = ENV['Youtube_API']

  def find_videos(keyword, after: 1.months.ago, before: Time.now)
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = GOOGLE_API_KEY

    next_page_token = nil
    opt = {
      q: keyword,
      type: 'video',
      max_results: 4,
      order: :date,
      page_token: next_page_token,
      published_after: after.iso8601,
      published_before: before.iso8601
    }
    service.list_searches(:snippet, opt)
  end

  def index
    if params[:keyword]
      @youtube_data = find_videos(params[:keyword])
    end
    @youtube = Youtube.new
  end

  def create
    @youtube = current_user.youtubes.new(youtube_params)
    @youtube.save ? redirect_to(users_users_path) : render(:index)
  end

  def destroy
    @youtube = Youtube.find(params[:id])
    @youtube.destroy ? redirect_to(users_users_youtube_path) : render(:favorite)
  end

  def favorite
    @youtubes = current_user.youtubes
  end

  private
  def youtube_params
    params.require(:youtube).permit(:youtube_title,:youtube_comment,:youtube_url)
  end

end
