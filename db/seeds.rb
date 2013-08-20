require 'open-uri'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all

user = User.create email: "admin@podstud.io", password: "admindemo1", password_confirmation: "admindemo1"
puts "Created User: #{user.email}"

urls = [
        "http://nerdist.libsyn.com/rss",
        "http://feeds.feedburner.com/howdidthisgetmade"
       ]

urls.each do |url|
  doc = Nokogiri::XML(open(url)).remove_namespaces!
  name = doc.xpath('/rss/channel/title').text
  description = doc.xpath('/rss/channel/description').text
  thumbnail = doc.xpath('/rss/channel/image').xpath('url').text
  last_build_date = doc.xpath('/rss/channel/lastBuildDate').text

  puts "Creating Podcast: #{name}"
  podcast = user.podcasts.build name: name, description: description, thumbnail: thumbnail, url: url, last_build_date: last_build_date
  podcast.save!

  items = doc.xpath('//item')

  items.each do |item|
    guid = item.xpath('guid').text
    title = item.xpath('title').text
    description = item.xpath('description').text
    link = item.xpath('link').text
    thumbnail = item.xpath('thumbnail').xpath('@url').text
    pubDate = item.xpath('pubDate').text
    content_url = item.xpath('content').xpath('@url').text
    file_size = item.xpath('content').xpath('@fileSize').text
    content_type = item.xpath('content').xpath('@type').text

    puts "Creating #{podcast.name} Episode: #{title} (#{guid})"
    episode = podcast.episodes.build guid: guid,
                                     title: title,
                                     description: description,
                                     link: link,
                                     thumbnail: thumbnail,
                                     pubdate: pubDate,
                                     content_url: content_url,
                                     file_size: file_size,
                                     content_type: content_type
    episode.save
  end
end
