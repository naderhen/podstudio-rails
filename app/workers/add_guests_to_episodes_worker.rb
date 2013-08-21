require 'open-uri'
class AddGuestsToEpisodesWorker
	include Sidekiq::Worker

	def perform(podcast_id)
		@podcast = Podcast.find(podcast_id)

		if @podcast.present?
			Guest.all.each do |guest|
		  		# puts "Searching All Episodes For #{guest.name}"
		  		episodes = @podcast.episodes.where("title like ? OR description like ?", "%#{guest.name}%", "%#{guest.name}%")
		  		if episodes.present?
		  			puts "Found #{guest.name} in #{episodes.count} episodes"
		  			episodes.each do |episode|
			  			Appearance.create guest_id: guest.id, episode_id: episode.id
		  			end
		  		end
		  	end
		end
	end
end
