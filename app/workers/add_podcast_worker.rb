require 'open-uri'
class AddPodcastWorker
  include Sidekiq::Worker

  def perform(url, user_id)
    doc = Nokogiri::XML(open(url)).remove_namespaces!
    name = doc.xpath('/rss/channel/title').text
    description = doc.xpath('/rss/channel/description').text
    thumbnail = doc.xpath('/rss/channel/image').xpath('url').text
    last_build_date = doc.xpath('/rss/channel/lastBuildDate').text
    link = doc.xpath('/rss/channel/link').text
    pubdate = doc.xpath('/rss/channel/pubDate').text
    generator = doc.xpath('/rss/channel/generator').text

    puts "Creating Podcast: #{name}"
    podcast = User.find(user_id).podcasts.build name: name, description: description, thumbnail: thumbnail, url: url, last_build_date: last_build_date, link: link, pubdate: pubdate, generator: generator
    podcast.save!

    items = doc.xpath('//item')

    items.each do |item|
      Podstudio::EpisodeHelper.create_from_xml(item, podcast.id)
    end
    AddGuestsToEpisodesWorker.perform_async(podcast.id)
  end
end
