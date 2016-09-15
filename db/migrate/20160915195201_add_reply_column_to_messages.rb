class AddReplyColumnToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :reply, :string
  end
end
