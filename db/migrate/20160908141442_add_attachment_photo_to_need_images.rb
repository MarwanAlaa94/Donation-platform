class AddAttachmentPhotoToNeedImages < ActiveRecord::Migration
  def self.up
    change_table :need_images do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :need_images, :photo
  end
end
