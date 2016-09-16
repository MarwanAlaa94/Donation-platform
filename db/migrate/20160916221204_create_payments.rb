class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.string :need_name
      t.integer :need_id
      t.integer :org_id
      t.integer :user_id
      t.float :donated_money
      t.string :comment
      t.boolean :is_recieved

      t.timestamps
    end
  end
end
