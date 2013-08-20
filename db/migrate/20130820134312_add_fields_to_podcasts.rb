class AddFieldsToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :link, :string
    add_column :podcasts, :pubdate, :datetime
    add_column :podcasts, :generator, :string
  end
end
