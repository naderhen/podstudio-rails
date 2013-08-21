module Podstudio
	module EpisodeHelper
		def self.create_from_xml(item, podcast_id)
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
	      episode
		end
	end
end
