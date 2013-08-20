class AddFieldsToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :enclosure_url, :string
    add_column :episodes, :enclosure_length, :integer
    add_column :episodes, :enclosure_type, :string
  end
end
