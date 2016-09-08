class AddAttachmentPhotoToOrgImages < ActiveRecord::Migration
  def self.up
    change_table :org_images do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :org_images, :photo
  end
end
