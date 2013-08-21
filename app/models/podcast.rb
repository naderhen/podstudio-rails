class Podcast < ActiveRecord::Base
  belongs_to :user
  has_many :episodes, dependent: :destroy

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
end
