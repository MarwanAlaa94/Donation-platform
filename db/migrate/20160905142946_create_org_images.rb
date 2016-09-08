class CreateOrgImages < ActiveRecord::Migration[5.0]
  def change
    create_table :org_images do |t|
      t.string :caption
      t.integer :organization_id

      t.timestamps
    end
  end
end
