class CreateNeeds < ActiveRecord::Migration[5.0]
  def change
    create_table :needs do |t|
      t.string :title
      t.string :description
      t.date :start_date
      t.date :end_date
      t.boolean :in_progress
      t.float :money
      t.integer :urgent_rate
      t.boolean :achievment_flag

      t.timestamps
    end
  end
end
