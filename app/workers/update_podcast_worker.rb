require 'open-uri'
class UpdatePodcastWorker
  include Sidekiq::Worker

  def perform(podcast_id)
    puts "UPDATING PODCAST: #{podcast_id}"
    @podcast = Podcast.find(podcast_id)

    if @podcast.present?
      doc = Nokogiri::XML(open(@podcast.url)).remove_namespaces!
      latest_entry = @podcast.episodes.first

      items = doc.xpath('//item')

      found_new_episodes = []

      items.each do |item|
        break if item.xpath('guid').text == latest_entry.guid
        new_episode = Podstudio::EpisodeHelper.create_from_xml(item, podcast_id)
        puts "CREATED EPISODE"
        found_new_episodes << new_episode
      end
      puts "FOUND #{found_new_episodes.count} NEW EPISODES"
    end
  end
end
