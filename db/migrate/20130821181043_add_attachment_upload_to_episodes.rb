class AddAttachmentUploadToEpisodes < ActiveRecord::Migration
  def self.up
    change_table :episodes do |t|
      t.attachment :upload
    end
  end

  def self.down
    drop_attached_file :episodes, :upload
  end
end
