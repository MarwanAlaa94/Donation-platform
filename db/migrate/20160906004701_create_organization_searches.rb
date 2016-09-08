class CreateOrganizationSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :organization_searches do |t|
      t.string :org_name
      t.string :email
      t.string :info
      t.string :website_URL
      t.string :contacts

      t.timestamps
    end
  end
end
