class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :organization_id
      t.integer :need_id
      t.integer :payment_id
      t.boolean :seen, :default => false
      t.integer :notification_type

      t.timestamps
    end
  end
end
