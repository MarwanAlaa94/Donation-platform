class AddDonatedMoneyToNeeds < ActiveRecord::Migration[5.0]
  def change
    add_column :needs, :donated_money, :float, :default => 0
  end
end
