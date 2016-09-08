class CreateJoinTableuserneed < ActiveRecord::Migration[5.0]
  def change
    create_join_table :users, :needs do |t|
      t.index [:user_id, :need_id]
       #t.index [:need_id, :user_id]
    end
  end
end
