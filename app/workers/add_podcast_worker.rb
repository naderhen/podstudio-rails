require 'open-uri'
class AddPodcastWorker
  include Sidekiq::Worker

  def perform(url, user_id)
    podcast = Podstudio::XMLHelper.create_podcast_from_xml(url, user_id)

    podcast.update_feed
    AddGuestsToEpisodesWorker.perform_async(podcast.id)
    podcast.delay.get_release_days_of_week
  end
end
