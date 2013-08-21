class Podcast < ActiveRecord::Base
  belongs_to :user
  has_many :episodes, dependent: :destroy
  has_many :release_predictions

  def xml_body
  	require 'open-uri'
  	Nokogiri::XML(open(self.url)).remove_namespaces!
  end

  def find_new_entries
  	doc = self.xml_body
  	items = doc.xpath('//item')
  	return items if self.episodes.count == 0
  	latest_episode = self.episodes.order('pubdate DESC').first

	found_new_entries = []

  	items.each do |item|
    	break if item.xpath('guid').text == latest_episode.guid
    	found_new_entries << item
  	end

  	found_new_entries
  end

  def update_feed
  	new_entries = self.find_new_entries

  	if new_entries.count > 0
  		Podstudio::XMLHelper.batch_create_episodes_from_xml(new_entries, self.id)
  	end
  	true
  end

  def get_release_days_of_week
  	results = []
  	episodes = self.episodes.order('pubdate DESC')
  	if episodes.count > 0
	  	beginning_date = episodes.first.pubdate
	  	end_date = episodes.last.pubdate

	  	number_of_weeks = (beginning_date - end_date).to_i / 1.week

	  	days = self.episodes.group_by{|e| e.pubdate.strftime("%A")}
	  	puts "Episodes For #{self.name} release on #{days.count} days:"

	  	self.release_predictions.destroy_all
	  	days.each do |day, episodes|
	  		percent = (episodes.count / number_of_weeks.to_f)
	  		puts "Episodes For #{self.name} have a #{percent * 100}% change of dropping on #{day}"
	  		results << ReleasePrediction.create(podcast_id: self.id, day: day, count: episodes.count, percent: percent)
	  	end
	end
  	results
  end
end
