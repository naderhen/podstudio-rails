module Podstudio
	module XMLHelper
		def self.create_podcast_from_xml(url, user_id)
			doc = Nokogiri::XML(open(url)).remove_namespaces!
		    name = doc.xpath('/rss/channel/title').text
		    description = doc.xpath('/rss/channel/description').text
		    thumbnail = doc.xpath('/rss/channel/image').xpath('url').text
		    last_build_date = doc.xpath('/rss/channel/lastBuildDate').text
		    link = doc.xpath('/rss/channel/link').text
		    pubdate = doc.xpath('/rss/channel/pubDate').text
		    generator = doc.xpath('/rss/channel/generator').text

		    puts "Creating Podcast: #{name}"
		    Podcast.create user_id: user_id, name: name, description: description, thumbnail: thumbnail, url: url, last_build_date: last_build_date, link: link, pubdate: pubdate, generator: generator
		end

		def self.create_episode_from_xml(item, podcast_id)
		  guid = item.xpath('guid').text
	      title = item.xpath('title').text
	      description = item.xpath('description').text
	      link = item.xpath('link').text
	      thumbnail = item.xpath('thumbnail').xpath('@url').text
	      pubDate = item.xpath('pubDate').text
	      content_url = item.xpath('content').xpath('@url').text
	      file_size = item.xpath('content').xpath('@fileSize').text
	      content_type = item.xpath('content').xpath('@type').text
	      duration = item.xpath('duration').text
	      explicit = item.xpath('explicit').text == "yes"
	      subtitle = item.xpath('subtitle').text

	      enclosure_url = item.xpath('enclosure/@url').text
	      enclosure_length = item.xpath('enclosure/@length').text
	      enclosure_type = item.xpath('enclosure/@type').text

	      puts "Creating Episode: #{title} in Podcast: #{podcast_id}"

	      episode = Episode.create podcast_id: podcast_id,
	      								   guid: guid,
	                                       title: title,
	                                       description: description,
	                                       link: link,
	                                       thumbnail: thumbnail,
	                                       pubdate: pubDate,
	                                       duration: duration,
	                                       content_url: content_url,
	                                       file_size: file_size,
	                                       content_type: content_type,
	                                       enclosure_url: enclosure_url,
	                                       enclosure_length: enclosure_length,
	                                       enclosure_type: enclosure_type,
	                                       explicit: explicit,
	                                       subtitle: subtitle
		end

		def self.batch_create_episodes_from_xml(items, podcast_id)
			items.each do |item|
				self.create_episode_from_xml(item, podcast_id)
			end
		end
	end
end
