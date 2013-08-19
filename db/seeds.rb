# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Podcast.destroy_all

user = User.create email: "admin@podstud.io", password: "admindemo1", password_confirmation: "admindemo1"
puts "Created User: #{user.email}"

podcast = Podcast.create name: "How Did This Get Made", user_id: user.id, description: "Have you ever seen a movie so bad that it's amazing? Paul Scheer, June Diane Raphael and Jason Mantzoukas want to hear about it! We'll watch it with our funniest friends, and report back to you with the results."
puts "Created Podcast: #{podcast.name} under user: #{podcast.user.email}"

doc = Nokogiri::XML(open('http://feeds.feedburner.com/howdidthisgetmade.xml')).remove_namespaces!
episodes = doc.xpath('//item')

episodes.each do |episode|
  title = episode.xpath('title').text
  description = episode.xpath('description').text
  pubDate = episode.xpath('pubDate').text
  content_url = episode.xpath('content').xpath('@url').text
end
