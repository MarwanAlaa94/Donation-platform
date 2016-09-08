class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :org_name
      t.string :email
      t.string :password
      t.string :info
      t.string :website_URL
      t.string :contacts
      t.string :logo_url

      t.timestamps
    end
  end
end
