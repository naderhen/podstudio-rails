class AddUrlToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :url, :string
  end
end
