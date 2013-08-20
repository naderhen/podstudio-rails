require 'open-uri'

namespace :podstudio do
  desc "Fetch Guests from Earwolf and Add Them To Database"
  task fetch_guests_from_earwolf: :environment do
  	guests = []
  	page = 1
  	while page < 30 do
  		puts "Getting Page #{page}"
	  	doc = Nokogiri::HTML(open("http://earwolf.com/people?page=#{page}role=guest")).remove_namespaces!
	  	doc.css('.person').each do |person|
	  	  guests << {name: person.at_css('h5').text, avatar: person.at_css('img')[:src]}
	  	end
	  	page += 1
	end
	puts "Creating #{guests.size} Guests"
  	Guest.destroy_all
  	Guest.create(guests)
  end

  desc "Check Title of Episodes Against Guest Names and Add"
  task add_guests_to_episodes_by_title: :environment do
  	Appearance.destroy_all
  	Guest.all.each do |guest|
  		# puts "Searching All Episodes For #{guest.name}"
  		episodes = Episode.where("title like ? OR description like ?", "%#{guest.name}%", "%#{guest.name}%")
  		if episodes.present?
  			puts "Found #{guest.name} in #{episodes.count} episodes"
  			episodes.each do |episode|
	  			Appearance.create guest_id: guest.id, episode_id: episode.id
  			end
  		end
  	end
  end

end
