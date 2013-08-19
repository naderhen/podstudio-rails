json.array!(@podcasts) do |podcast|
  json.extract! podcast, :name, :user_id, :description
  json.url podcast_url(podcast, format: :json)
end
