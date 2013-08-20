# <?xml version="1.0" encoding="UTF-8"?>
xml=Builder::XmlMarkup.new(:indent => 3)
xml.instruct!

# <rss xmlns:itunes="http://www.itunes.com/DTDs/Podcast-1.0.dtd" version="2.0">
xml.rss "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd",  "xmlns:media" => "http://search.yahoo.com/mrss/",  :version => "2.0" do

#     <channel>
	xml.channel do
#       <title>RSS Feed Podcast</title>
		xml.title @podcast.name

#       <description>Podcast explaining the ins and outs of RSS, RSS feeds, feed creation, optimization and use as a marketing technology. The podcast is prepared using voice synthesis, reading articles related to RSS.</description>
		xml.description @podcast.description

#         <link>http://www.rss-specifications.com/rss-articles.htm</link>
		xml.link @podcast.link

#         <lastBuildDate>Mon, 25 Jul 2005 16:37:32 -0400</lastBuildDate>
		xml.lastBuildDate @podcast.last_build_date

#         <pubDate>Mon, 25 Jul 2005 09:00:00 -0400</pubDate>
		xml.pubDate @podcast.pubdate

#         <generator>FeedForAll Mac v1.0 (1.0.1.0) unlicensed version</generator>
		xml.generator @podcast.generator

#         <itunes:category text="Technology">
#             <itunes:category text="Information Technology"/>
#         </itunes:category>
		xml.itunes :category, :text => "Category Text" do
			xml.itunes :category, :text => 'Software How-To'
		end

#         <itunes:subtitle>Podcasting made easy with FeedForAll</itunes:subtitle>
		xml.itunes :subtitle, "SUBTITLE"

#         <itunes:summary>Podcasting tutorial developed by the FeedForAll Mac Team to walk you through the steps necessary to publish a podcast on iTunes Music Store using this very program. Simple and precise instructions will guide you through creating an RSS feed that can contain audio, artwork, or simple xml.</itunes:summary>
		xml.itunes :summary, "TEST"

#         <itunes:author>FeedForAll Mac OS Team</itunes:author>
		xml.itunes :author, "AUTHOR"

#         <itunes:owner>
#             <itunes:name>FeedForAll Mac OS Team</itunes:name>
#             <itunes:email>macsupport@feedforall.com</itunes:email>
#         </itunes:owner>
		xml.itunes :owner do
	      xml.itunes :name, "AUTHOR"
	      xml.itunes :email, 'TEST@TEST.COM'
	    end

#         <itunes:image>
#             <url>http://www.feedforall.com/logo.jpg</url>
#             <title>FeedForAll Logo</title>
#             <link>http://www.feedforall.com</link>
#         </itunes:image>
#         <itunes:link rel="image" type="video/jpeg" href="http://www.feedforall.com/logo.jpg">- FeedForAll Podcasting Tutorial</itunes:link>

#         <item>
#             <title>Tips to Creating a Blog</title>
#             <description>Tips for creating a blog.&lt;br&gt;
# There are no hard and fast rules on how to blog. Having said that, bloggers will likely increase their exposure by following some simple blog guidelines. &lt;br&gt;&lt;br&gt;
# 1) Stay on topic.&lt;br&gt;
# Opinions are generally accepted but the content of the items in the blog should all relate to a general theme. Unless you have an uncanny knack for wit, humor or cynicism, the majority of your readers will be interested in the content that relates to a specific defined theme or loosely defined area of interest. Most readers won&amp;apos;t care that you eat Cheerios for breakfast. They may, however, be interested in the fact that vinegar takes out stains and that toilet paper rolls make great wreaths. Define a topic and stick to it. This will ensure that you create a loyal following of interested readers.&lt;br&gt;&lt;br&gt;</description>
#             <link>http://www.rss-specifications.com/10-tips-for-bloggers.htm</link>
#             <enclosure url="http://www.rss-specifications.com/podcasts/tips_to_creating_a_blog.mp3" length="1157907" type="audio/mpeg"></enclosure>
#             <pubDate>Mon, 25 Jul 2005 09:00:00 -0400</pubDate>
#             <itunes:category text="Technology">
#                 <itunes:category text="Information Technology"/>
#             </itunes:category>
#             <itunes:explicit>no</itunes:explicit>
#             <itunes:duration>4:49</itunes:duration>
#             <itunes:keywords>BLOG create howto</itunes:keywords>
#         </item>
		@podcast.episodes.each do |episode|
		  xml.item do
		  	xml.guid episode.guid
		  	xml.title episode.title
		  	xml.description episode.description
		  	xml.link episode.link
		  	xml.enclosure :url => episode.enclosure_url, :length => episode.enclosure_length, :type => episode.enclosure_type
		  	xml.pubDate episode.pubdate
		  	xml.itunes :author, "AUTHOR"
	        xml.itunes :subtitle, episode.subtitle
	        xml.itunes :summary, episode.description
	        xml.itunes :explicit, episode.explicit ? "yes" : "no"
	        xml.itunes :duration, episode.duration
		  end
		end
	end
#     </channel>
# </rss>
end



