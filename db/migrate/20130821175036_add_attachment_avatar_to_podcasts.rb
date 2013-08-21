class AddAttachmentAvatarToPodcasts < ActiveRecord::Migration
  def self.up
    change_table :podcasts do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :podcasts, :avatar
  end
end
