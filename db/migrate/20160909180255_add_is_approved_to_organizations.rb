class AddIsApprovedToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :isApproved, :boolean, :default => false
  end
end
