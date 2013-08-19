class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :title
      t.text :description
      t.datetime :pubdate
      t.string :content_url
      t.integer :podcast_id

      t.timestamps
    end
  end
end
