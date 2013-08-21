class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
    @release_predictions = ReleasePrediction.where("percent > ?", 0.2).order("percent DESC").group_by(&:day)
  end

  def fetch_feed
  	if params[:url].present?
  		@url = params[:url]
  		AddPodcastWorker.perform_async(@url, current_user.id)
  	end
  	redirect_to podcasts_path
  	return
  end
end
