xml=Builder::XmlMarkup.new(:indent => 3)
xml.instruct!
xml.rss("version" => "2.0" ,  "xmlns:g" => "http://base.google.com/ns/1.0" , "xmlns:atom" => "http://www.w3.org/2005/Atom") do
	xml.channel do
		xml.title @podcast.name
		xml.description @podcast.description
		xml.lastBuildDate @podcast.last_build_date
		xml.tag! "itunes:summary", "test"
		xml.tag! "itunes:owner" do
			xml.url "test"
			xml.email "email"
		end

		@podcast.episodes.each do |episode|
		  xml.item do
		  	xml.title episode.title
		  end
		end
	end
end



