class AddKeywordToSearch < ActiveRecord::Migration[5.0]
  def change
    add_column :searches, :keyword, :string
  end
end
