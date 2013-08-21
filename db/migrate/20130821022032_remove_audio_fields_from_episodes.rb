class RemoveAudioFieldsFromEpisodes < ActiveRecord::Migration
  def change
    remove_column :episodes, :audio_file_file_name, :string
    remove_column :episodes, :audio_file_content_type, :string
    remove_column :episodes, :audio_file_file_size, :integer
    remove_column :episodes, :audio_file_updated_at, :datetime
  end
end
