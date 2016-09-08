class AddOrganizationIdToNeeds < ActiveRecord::Migration[5.0]
  def change
    add_column :needs, :organization_id, :integer
    add_index  :needs, :organization_id
  end
end
