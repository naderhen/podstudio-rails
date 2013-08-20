class AddGuidToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :guid, :string
    add_column :episodes, :link, :string
    add_column :episodes, :thumbnail, :string
    add_column :episodes, :file_size, :integer
    add_column :episodes, :content_type, :string
  end
end
